require './exception_handler.rb'
require './manufacturer.rb'
require './instance_counter.rb'
require './station.rb'
require './route.rb'
require './train.rb'
require './carriage.rb'
require './cargo_carriage.rb'
require './passenger_carriage.rb'
require './passenger_train.rb'
require './cargo_train.rb'

def test(test_number, condition, msg = '')
  puts condition ? "#{test_number}  |TRUE |  #{msg}" : "#{test_number} [[FALSE]] #{msg}"
end

# 1
s1 = Station.new('Blob')
s2 = Station.new('Bar')
s3 = Station.new('Var')

# 2
PassengerTrain.new('STA-22')
# 3
CargoTrain.new('BUL-77')

r = Route.new(s1, s2)
r.add_station(s3)

cargo_carriage = CargoCarriage.new(300)
passenger_carriage = PassengerCarriage.new(48)
passenger_carriage2 = PassengerCarriage.new(24)
cargo_carriage.take_up_valume(150)
21.times { passenger_carriage.take_a_seat }

PassengerTrain.find('STA-22').add_carriage(passenger_carriage)
PassengerTrain.find('STA-22').add_carriage(passenger_carriage2)
CargoTrain.find('BUL-77').add_carriage(cargo_carriage)
PassengerTrain.find('STA-22').initialize_route(r)
CargoTrain.find('BUL-77').initialize_route(r)

#-----------------------------------------------------------------------------
test 1, Station.instances == 3, 'number of stations'
test 2, PassengerTrain.instances == 1, 'create passenger train'
test 3, CargoTrain.instances == 1, 'create cargo train'
test 4, PassengerTrain.find('STA-22').number == 'STA-22', 'faind train by number'
puts '----------------------------------------'
#-----------------------------------------------------------------------------

PassengerTrain.find('STA-22').each_carriage_to_block_with_index { |carriage| puts carriage.inspect }
CargoTrain.find('BUL-77').each_carriage_to_block_with_index { |carriage| puts carriage.inspect }
puts '----------------------------------------'
Station.all.each do |station|
  station.each_train_to_block_with_index do |train|
    puts "#{train.number} #{train.class}-carriages ammout: #{train.carriages.size}"
    train.each_carriage_to_block_with_index(1) do |carriage, index|
      carriage_number = "Carriage-number-#{index} #{carriage.class}"
      if carriage.class.to_s['Cargo']
        puts " \\_ #{carriage_number} volume_left:#{carriage.free_space} occupaid_volume:#{carriage.space_left}"
      else
        puts " \\_ #{carriage_number} free_seats:#{carriage.free_space} occupied_seats:#{carriage.space_left}"
      end
    end
  end
end
