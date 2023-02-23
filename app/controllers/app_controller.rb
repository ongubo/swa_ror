class AppController < ApplicationController
  def index
    @elections = Election.all
    puts "At index new page"
    render :template =>'/elections/index', :layout => 'layouts/index'

  end
  def elections
    
  end


  def election
  end
end
