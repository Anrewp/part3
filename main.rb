require './station.rb'
require './route.rb'
require './train.rb'
require './cargo_train.rb'
require './passenger_train.rb'
require './carriage.rb'
require './cargo_carriage.rb'
require './passenger_carriage.rb'

def create_station
  puts "Add station name: "
  Station.new(gets.chomp.to_s)
end

def create_train
  puts "Enter train number: "
  number = gets.chomp.to_s
  puts "Train types: "
  puts "enter 1 for Cargo Train"
  puts "enter 2 for Passenger Train"
  result = gets.chomp.to_i

  case result
  when 1 then CargoTrain.new(number)
  when 2 then PassengerTrain.new(number)
  else return
  end
end

def create_route
  available_stations
  first_station = Station.get_station(gets.chomp.to_i)
  return unless first_station
  available_stations
  second_station = Station.get_station(gets.chomp.to_i)
  return unless second_station
  Route.new(first_station, second_station)
end

def add_station_to_route
  route, station = choose_route_and_station
  route.add_station(station)
end

def remove_station_from_route
  route, station = choose_route_and_station
  route.remove_station(station)
end

def assign_train_to_route
  available_routes
  r = Route.get_route(gets.chomp.to_i)
  t = find_train
  t.initialize_route(r)
end

def add_carriege_to_train
  t = find_train
  c =  t.class.to_s['Cargo'] ? CargoCarriage.new : PassengerCarriage.new
  t.add_carriage(c)
end

def remove_carriege_from_train
  t = find_train
  available_info('carriage')
  t.carriages.each_with_index { |carriage, index| puts "#{carriage} - #{index}" }
  choose_info('carriage')
  help_info
  c = t.carriages[gets.chomp.to_i]
  t.remove_carriage[c]
end

def move_train_to_the_next_station
  t = find_train
  t.move_to_the_next_station
end

def move_train_to_the_previous_station
  t = find_train
  t.move_to_the_previous_station
end

def show_all_stations
  Station.show_all
end

def show_all_trains_on_station
  available_stations
  puts Station.get_station(gets.chomp.to_i).train_list
end

# - - - - - - - - HELP SECTION - - - - - - - - - - - - - - - - - - 
def help_info
  puts "(Enter number from above list)"
end

def available_info(type)
  puts "Available #{type}s are next: "
end

def choose_info(type)
  puts "Choose #{type}: "
end

def available_stations
  available_info('station')
  Station.all.each_with_index { |station, index| puts "#{station.station_name} - #{index}" }
  choose_info('station')
  help_info
end

def available_routes
  available_info('route')
  Route.all.each_with_index { |station, index| puts "Route - #{index}" }
  choose_info('route')
  help_info
end

def choose_route_and_station
  available_routes
  r = Route.get_route(gets.chomp.to_i)
  available_stations
  s = Station.get_station(gets.chomp.to_i)
  [r, s]
end

def find_train
  trains = []
  trains << CargoTrain.all
  trains << PassengerTrain.all
  trains.flatten!
  available_info('train')
  trains.each_with_index { |train, index| puts "#{train.class} number: #{train.number} - #{index}" }
  choose_info('train')
  help_info
  trains[gets.chomp.to_i]
end
# _________________________________________________________________

loop do

  puts "- - - - - - - - - - - - - - - - - - - - - - - -"
  puts "Choose 1 to create station"
  puts "Choose 2 to create train"
  puts "Choose 3 to create route"
  puts "Choose 4 to add station to route"
  puts "Choose 5 to remove station from route"
  puts "Choose 6 to assign train to route"
  puts "Choose 7 to add carriage to train"
  puts "Choose 8 to remove carriage from train"
  puts "Choose 9 to transfer train to the next stations"
  puts "Choose 10 to transfer train to the previous stations"
  puts "Choose 11 to Show all stations"
  puts "Choose 12 to Show all trains on station"
  puts "- - - - - - - - - - - - - - - - - - - - - - - -"
  option = gets.chomp.to_i

  case option
  when 1 then create_station
  when 2 then create_train
  when 3 then create_route
  when 4 then add_station_to_route
  when 5 then remove_station_from_route
  when 6 then assign_train_to_route
  when 7 then add_carriege_to_train
  when 8 then remove_carriege_from_train
  when 9 then move_train_to_the_next_station
  when 10 then move_train_to_the_previous_station
  when 11 then show_all_stations
  when 12 then show_all_trains_on_station
  else break
  end

end
