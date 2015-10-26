class User < ActiveRecord::Base
  rolify
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  has_many :likes
  acts_as_voter

  def set_default_role
    self.role ||= :user
  end

  # def likes?(product)
  #   product.likes.where(user_id: id).any?
  # end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
