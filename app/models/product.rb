class Product < ActiveRecord::Base
  has_and_belongs_to_many :campaigns
  attachment :image
  has_many :likes
  belongs_to :user
  has_many :comments, as: :commentable
  acts_as_votable

end
