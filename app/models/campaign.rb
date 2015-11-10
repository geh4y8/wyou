class Campaign < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
has_many :donations
has_many :supporters
has_many :users, :through => :supporters
has_one :store
has_and_belongs_to_many :products
has_many :comments, as: :commentable
#has_and_belongs_to_many :likes
# has_many :products, :through => :campaigns_products

  def goal_percentage(campaign)
    goal_percentage = ((campaign.fund_amount.to_f/campaign.fund_goal.to_f) *100)
    return goal_percentage.to_i
  end

  def supporters_image_count(campaign)
    supporters_array = []
    supporters = campaign.supporters.order("RANDOM()").limit(8)
    supporters_array << supporters(0..3)
    supporters_array << supporters(4..7)
    return supporters_array
  end

end
