require './station.rb'
require './train.rb'
require './route.rb'

s1 = Station.new("First Station")
s2 = Station.new("Second Station")
s3 = Station.new("Third Station")

r = Route.new(s1, s3)
r.add_passing_station(s2)

t = Train.new('VMH53', 'passenger', 16)

t.initialize_route(r)

# puts  s1.train_list.values.first.number
# puts s1.train_list_by_type
# s1.send_train(t)
# puts s1.train_list_by_type

# t.current_station
# puts t.current_station&.station_name
# puts t.next_station&.station_name
# puts t.previous_station&.station_name

# puts t.current_station&.station_name
# puts t.next_station.station_name
# puts "- - - "
# t.move_to_the_next_station
# puts t.current_station&.station_name
# puts "- - - "
# t.move_to_the_next_station
# puts t.current_station&.station_name
# puts "- - -"
# t.move_to_the_next_station
# puts t.current_station&.station_name

puts t.current_station&.station_name
puts t.previous_station&.station_name
t.move_to_the_previous_station
puts t.current_station&.station_name
t.move_to_the_next_station
puts t.current_station&.station_name
t.move_to_the_previous_station
puts t.current_station&.station_name
