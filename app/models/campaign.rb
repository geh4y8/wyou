class Campaign < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :donations
  has_many :supporters
  has_many :users, :through => :supporters
  has_one :store
  has_and_belongs_to_many :products
  has_many :comments, as: :commentable
  has_many :orders
  has_many :invites
  attachment :image

  def goal_percentage(campaign)
    if campaign.fund_amount > 0
      goal_percentage = ((campaign.fund_amount.to_f/campaign.fund_goal.to_f) *100)
    end
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
