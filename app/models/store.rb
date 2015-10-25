class Store < ActiveRecord::Base
  belongs_to :campaign
  has_many :products
end
