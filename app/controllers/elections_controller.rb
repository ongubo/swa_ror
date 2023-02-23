# require 'httparty'

class ElectionsController < ApplicationController
  before_action :set_election, only: %i[ show update destroy ]

  # GET /elections
  def index
      
    @elections = Election.all

    render json: @elections
  end

   # GET /populate
   def populate
    puts ["API_URL"]
    query = { 
      "key"  => "AIzaSyArC6LLZp_VB6PMdc7g3nGss-5vV-kvoy8",
      "address"=> "new york"
    }


    # Get elections and representatives from google API
    elections_response = HTTParty.get("https://www.googleapis.com/civicinfo/v2/elections",:query => query).parsed_response
    representatives_response = HTTParty.get("https://www.googleapis.com/civicinfo/v2/representatives",:query => query).parsed_response
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

    json_representatives.each do |representative|
      params = {
        "name":representative["name"],
        "party":representative["party"],
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
    render json: @election
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
