class Order < ActiveRecord::Base

  belongs_to :campaign
  has_and_belongs_to_many :products

  def current_step
    current_step || steps.first
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def steps
    %w[shipping billing confirmation]
  end

end
