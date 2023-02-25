class AppController < ApplicationController
  # Get all elections and render a page
  def index
    @elections = Election.all
    render :template =>'/elections/index', :layout => 'layouts/index'
  end

  # Get Single election and representatives assosiated
  def get_election
    @election = Election.find_by_id!(params[:election_id])
    @representatives = Representative.where(election_id: params[:election_id])
    render :template =>'/elections/election', :layout => 'layouts/index'
  end

  def new
    @election = Election.new
    render :template =>'/elections/new', :layout => 'layouts/index'
  end

  # Create elections and redirect to all elections

  def create
    @election = Election.new(elec_params)
    if @election.save
      redirect_to get_elections_url
    else
      render :new
    end
  end
end
