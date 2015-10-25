class Product < ActiveRecord::Base
  has_and_belongs_to_many :campaigns
  attachment :image
end
