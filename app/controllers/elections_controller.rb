# require 'httparty'

class ElectionsController < ApplicationController
  before_action :set_election, only: %i[ show update destroy ]

  # GET /elections
  def index
      
    @elections = Election.all

    render json: @elections.include(:representatives)
  end

   # GET /populate
   def populate
    puts ENV["API_URL"]
    query = { 
      "key"  => ENV["API_KEY"],
      "address"=> "new york"
    }


    # Get elections and representatives from google API
    elections_response = HTTParty.get(ENV["API_URL"]+"/elections",:query => query).parsed_response
    representatives_response = HTTParty.get(ENV["API_URL"]+"/representatives",:query => query).parsed_response
    json_elections = elections_response["elections"]
    json_representatives = representatives_response["officials"]
    

    # Add them to DB SQLite
    json_elections.each do |election|
      params = {
        "name":election["name"],
        "election_day":election["electionDay"],
        "division":election["ocdDivisionId"]
      }
      if Election.where(:name => election["name"]).empty?
        @election = Election.new(params)
        @election.save
        puts election["name"]+"+++++++++++++ saved to DB"
      end
    end

    # count elections to set the upper limit. this will be used to randomly assign representatives
    lmt= Election.count()
    json_representatives.each do |representative|
      params = {
        "name":representative["name"],
        "party":representative["party"],
        # Randomly assign representatives to elections
        "election_id":rand(1..lmt),
        "phone":representative["phones"][0]
      }
      if Representative.where(:name => representative["name"]).empty?
        @representative = Representative.new(params)
        @representative.save
        puts representative["name"]+"+++++++++++++ saved to DB"
      end
    end
    render json: json_representatives
  end
  # GET /elections/1
  def show
    render json: @election.include(:representative), only: [:name, :party]
  end

  # POST /elections
  def create
    @election = Election.new(election_params)

    if @election.save
      render json: @election, status: :created, location: @election
    else
      render json: @election.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /elections/1
  def update
    if @election.update(election_params)
      render json: @election
    else
      render json: @election.errors, status: :unprocessable_entity
    end
  end

  # DELETE /elections/1
  def destroy
    @election.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_election
      @election = Election.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def election_params
      params.require(:election).permit(:name)
    end
end
