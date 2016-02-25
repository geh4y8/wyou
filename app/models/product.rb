class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_and_belongs_to_many :campaigns
  has_and_belongs_to_many :categories
  attachment :image
  has_many :likes
  belongs_to :user
  has_many :comments, as: :commentable
  has_and_belongs_to_many :orders
  acts_as_votable
end
