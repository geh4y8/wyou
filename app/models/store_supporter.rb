class StoreSupporter < ActiveRecord::Base

  belongs_to :campaign
  belongs_to :user

end
