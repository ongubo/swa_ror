class AppController < ApplicationController
  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  # private

  # def record_not_found
  #   render file: "#{Rails.root}/public/404", layout: true, status: :not_found
  # end


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
