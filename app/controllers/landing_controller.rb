class LandingController < ApplicationController

  def index
    @landing = true
  end

  def recipients
    render 'recipients'
  end

end
