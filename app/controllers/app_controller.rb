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
end
