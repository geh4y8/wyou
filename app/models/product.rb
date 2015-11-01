class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_and_belongs_to_many :campaigns
  attachment :image
  has_many :likes
  belongs_to :user
  has_many :comments, as: :commentable
  acts_as_votable

end
