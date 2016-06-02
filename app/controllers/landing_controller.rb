class LandingController < ApplicationController

  def index
    @landing = true
  end

  def landing_2
    @landing = true
  end

  def recipients
    render 'recipients'
  end

end
