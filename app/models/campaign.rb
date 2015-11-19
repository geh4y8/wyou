class Campaign < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
has_many :donations
has_many :supporters
has_many :users, :through => :supporters
has_one :store
has_and_belongs_to_many :products
has_many :comments, as: :commentable
attachment :image
#has_and_belongs_to_many :likes
# has_many :products, :through => :campaigns_products

  def goal_percentage(campaign)
    goal_percentage = ((campaign.fund_amount.to_f/campaign.fund_goal.to_f) *100)
    return goal_percentage.to_i
  end

  def supporters_image_count(campaign)
    supporters = campaign.supporters.order("RANDOM()").limit(8)
    supporters = supporters.map {|x|
      if x.user.image_id
        x
      end}

    return supporters
  end

end
