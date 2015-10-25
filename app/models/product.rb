class Product < ActiveRecord::Base
  has_and_belongs_to_many :campaigns
  # has_many :stores
  attachment :image
  has_many :likes
  has_many :likes, :through => :campaigns_products
  belongs_to :user
  acts_as_votable

end
