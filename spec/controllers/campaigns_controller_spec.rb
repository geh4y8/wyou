require 'rails_helper'

RSpec.describe CampaignsController, :type => :controller do

  describe "#index" do
    it "should display all campaigns" do
      user = double('user')
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
      campaign1, campaign2 = Campaign.create!, Campaign.create!
      get :index
      expect(response).to be_success
      expect(response).to render_template("index")
      expect(assigns(:campaigns)).to match_array([campaign1, campaign2])
    end
  end
end
