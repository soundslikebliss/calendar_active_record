require 'active_record'
require './lib/event'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

def landing_menu
  puts "----------------------\n\n"
  puts "This be your calendar!"
  puts "\n----------------------\n\n"
  puts "Press 'E' to add, edit, list, or delete events"
  puts "Press 'X' to exit your calendar"
  choice = gets.chomp.downcase
    case choice
    when 'e'
      event_menu
    when 'x'
      puts "Peace out!\n\n"
      exit
    else
      puts "Oh, really?\n\n"
      exit
    end
  end


def event_menu
puts "Press 'C' to create a new event,
      'E' to edit an event,
      'L' to list all events,
      or 'D' to delete an event.
      Press 'M' to return to the main menu."

choice = gets.chomp.downcase
  case choice
  when 'c'
    create_event
  when 'e'
    edit_event
  when 'l'
    Event.list
  when 'd'
    delete_event
  when 'm'
    landing_menu
  else
    error
  end
end


def create_event
puts "What is the event you are creating?"
new_description = gets.chomp
puts "Where is this event taking place?"
new_location = gets.chomp
puts "What day and time does this event begin (eg. 2014-09-17 12:30)?"
new_start_time = gets.chomp
puts "What day and time does this event end (eg. 2014-09-17 1:30)?"
new_end_time = gets.chomp

new_event = Event.create({description: new_description, location: new_location, start:new_start_time, finish: new_end_time})

puts "Would you like to add another event? Y or N"
choice = gets.chomp.downcase
  if choice == 'y'
    create_event
  elsif choice == 'n'
    landing_menu
  else
    error
  end
end

# def list_events

# end

def error
  puts "Please try again.\n\n"
  landing_menu
end

landing_menu
