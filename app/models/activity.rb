class Activity < ApplicationRecord
  attr_writer :current_step

  validate :valid_name?, :if => lambda { |o| o.current_step == "name" }
  validate :valid_address?, :if => lambda { |o| o.current_step == "address" }
  validate :valid_time?, :if => lambda { |o| o.current_step == "schedule" }
  validate :invalid_schedule?, :if => lambda { |o| o.current_step == "schedule" }

  def valid_name?
    errors.add(:base, 'Please enter valid name') unless name.present?
  end

  def valid_address?
    errors.add(:base, 'Please enter valid address') unless address.present?
  end

  def valid_time?
    errors.add(:base, 'Please enter valid start_at') unless starts_at.present?
    errors.add(:base, 'Please enter valid end_at') unless ends_at.present?
  end

  def invalid_schedule?
    errors.add(:base, 'Ends At should be ahead Starts At') unless starts_at.present? && ends_at.present? && (starts_at < ends_at)
  end

  def steps
    %w[name address schedule]
  end

  def current_step
    @current_step || steps.first
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

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
end
