class ContactController < ApplicationController

  def index
  end

  def submit
    @message = "Thanks for sending your response"
    
    render :index
    #So he never actually needs a separate submit page. It simply inserts another line of html into the index page.
    
  end
end
