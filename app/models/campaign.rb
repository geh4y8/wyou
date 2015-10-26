class Campaign < ActiveRecord::Base
has_many :donations
has_many :supporters
has_many :users, :through => :supporters
has_one :store
has_and_belongs_to_many :products
has_and_belongs_to_many :likes
# has_many :products, :through => :campaigns_products

  def goal_percentage(campaign)
    goal_percentage = ((campaign.fund_amount.to_f/campaign.fund_goal.to_f) *100)
    return goal_percentage.to_i
  end

end
