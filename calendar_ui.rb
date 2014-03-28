require 'active_record'
require './lib/event'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

@@description = :description




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
puts "\nPress 'C' to create a new event,
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
    puts "\n\n"
    list_events
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

def list_events
    @sorty_thing = Event.all.each do |x|
    x.description.upcase
    x.location.titlecase
    x.start
    x.finish
  end
    @sorty_thing.sort_by { |k, v | v[:start] }
    puts "#{@sorty_thing.description}:
    at: #{@sorty_thing.location}
    starting at: #{@sorty_thing.start}
    ending at: #{@sorty_thing.finish}"
    puts "----------------\n\n"
    landing_menu
end

def edit_event
  puts "\nThese are the events available for editing:\n\n"

    events_with_indexes

    puts "\nWhich event number would you like to edit?"
    choice = gets.chomp.to_i
    choice_at_index = Event.all[choice - 1]

    puts "\nYou have selected #{choice_at_index.description.upcase}\n\n"

    puts "Press 'E' change the event description,
        'L' to change the event location,
        'S' to change the start time,
        or 'F' to change the finish time.
        Press 'M' to return to the main menu."
    selection = gets.chomp.downcase
      case selection
      when 'e'
        puts "\nWhat is the new event description?"
        event_description = gets.chomp.downcase
        choice_at_index.update({description: event_description})
        puts "\nDescription updated!"
        more_edits

      when 'l'
        puts "\nWhat is the new event location?"
        event_location = gets.chomp.downcase
        choice_at_index.update({location: event_location})
        puts "\nLocation updated!"
        more_edits

      when 's'
        puts "\nWhat is the new start time?"
        event_start_time = gets.chomp.downcase
        choice_at_index.update({start: event_start_time})
        puts "\nStarting time updated!"
        more_edits

      when 'f'
        puts "\nWhat is the new finish time?"
        event_finish_time = gets.chomp.downcase
        choice_at_index.update({finish: event_finish_time})
        puts "\nEnding time updated!"
        more_edits

      else
        landing_menu
    end
end

def delete_event
  events_with_indexes
  puts "Which event number would you like to delete?"
  delete_choice = gets.chomp.to_i
  Event.all[delete_choice - 1].destroy
  edit_event
end

def more_edits
  puts "Would you like to make more edits? Y or N"
  edit_choice = gets.chomp.downcase
  if edit_choice == 'y'
    edit_event
  else
    landing_menu
  end
end

def events_with_indexes
  Event.all.each_with_index do | x, index |
    puts "#{index + 1}. #{x.description.titlecase}"
  end
end


def error
  puts "Please try again.\n\n"
  landing_menu
end

landing_menu
