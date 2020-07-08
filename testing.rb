require './manufacturer.rb'
require './instance_counter.rb'
require './station.rb'
require './route.rb'
require './train.rb'
require './passenger_train.rb'
require './cargo_train.rb'

Station.new('Blob')
Station.new('Bar')

Train.new('g555')

PassengerTrain.new('f222')
PassengerTrain.new('f333')

CargoTrain.new('b777')

puts Station.instances == 2
puts Train.instances == 1
puts PassengerTrain.instances == 2
puts CargoTrain.instances == 1

puts PassengerTrain.find('f222').number == 'f222'
