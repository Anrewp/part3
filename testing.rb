require './exception_handler.rb'
require './manufacturer.rb'
require './instance_counter.rb'
require './station.rb'
require './route.rb'
require './train.rb'
require './passenger_train.rb'
require './cargo_train.rb'

s1 = Station.new('Blob')
s2 = Station.new('Bar')
s3 = Station.new('Var')

Train.new('DGH-55')

PassengerTrain.new('STA-22')
PassengerTrain.new('SDA-333')

CargoTrain.new('BUL-77')

r = Route.new(s1, s2)
r.add_station(s2)

puts Station.instances == 2
puts Train.instances == 1
puts PassengerTrain.instances == 1
puts CargoTrain.instances == 1

puts PassengerTrain.find('STA-22').number == 'STA-22'

