require 'spec_helper'

describe Event do
  describe '.sorted' do
    it "should return the dates sorted with the most recent first" do
      event1 = Event.create({:start => '2014-03-29 10:00', :finish => '2014-03-29 12:00'})
      event2 = Event.create({:start => '2014-03-28 10:00', :finish => '2014-03-28 12:00'})
      Event.sorted.should eq [event2, event1]
    end
  end
end
