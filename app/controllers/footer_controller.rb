class FooterController < ApplicationController
  
  def index
    render :partial => 'layouts/footer', :layout => 'layouts/footer'
  end

end