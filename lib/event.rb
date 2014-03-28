class Event < ActiveRecord::Base

  def self.sorted
    Event.order(:start)
  end

end
