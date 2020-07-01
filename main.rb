require './station.rb'
require './train.rb'
require './route.rb'

s1 = Station.new("First Station")
s2 = Station.new("Second Station")
s3 = Station.new("Third Station")

r = Route.new(s1, s3)
r.add_station(s2)

t  = Train.new('VMH53', 'passenger', 16)
t3  = Train.new('VMadsH53', 'passenger', 16)
t2 = Train.new('VMH55', 'freight', 10)

# t.initialize_route(r)

s1.acept_train(t)
s1.acept_train(t2)
s1.acept_train(t3)

puts s1.train_list_by_type('passenger')
puts s1.train_list_by_type('freight')


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

# puts t.current_station&.station_name
# puts t.previous_station&.station_name
# t.move_to_the_previous_station
# puts t.current_station&.station_name
# t.move_to_the_next_station
# puts t.current_station&.station_name
# t.move_to_the_previous_station
# puts t.current_station&.station_name
