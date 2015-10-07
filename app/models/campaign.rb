class Campaign < ActiveRecord::Base
has_many :donations
has_many :users

  def goal_percentage(campaign)
    goal_percentage = ((campaign.fund_amount.to_f/campaign.fund_goal.to_f) *100)
    return goal_percentage.to_i
  end

end
