class Event < ActiveRecord::Base

  def self.list
    Event.all.each do |x|
      puts "#{x.description} at #{x.location} between #{x.start} and #{x.finish}"
      puts "----------------"
    end
  end
end
