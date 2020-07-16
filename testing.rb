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

def test(test_number, condition,  msg = '')
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
passenger_carriage_2 = PassengerCarriage.new(24)
cargo_carriage.take_up_valume(150)
21.times { passenger_carriage.take_a_seat }

PassengerTrain.find('STA-22').add_carriage(passenger_carriage)
PassengerTrain.find('STA-22').add_carriage(passenger_carriage_2)
CargoTrain.find('BUL-77').add_carriage(cargo_carriage)
PassengerTrain.find('STA-22').initialize_route(r)
CargoTrain.find('BUL-77').initialize_route(r)


#-----------------------------------------------------------------------------
test 1, Station.instances == 3, 'number of stations'
test 2, PassengerTrain.instances == 1, 'create passenger train'
test 3, CargoTrain.instances == 1, 'create cargo train'
test 4, PassengerTrain.find('STA-22').number == 'STA-22', 'faind train by number'
puts "----------------------------------------"
#-----------------------------------------------------------------------------

PassengerTrain.find('STA-22').each_carriage_to_block_with_index { |carriage| puts carriage.inspect }
Station.all.each do |station|
  station.each_train_to_block_with_index do |train|
    puts "#{train.number} #{train.class.to_s}-carriages ammout: #{train.carriages.size}"
    train.each_carriage_to_block_with_index(1) do |carriage, index|
      if carriage.class.to_s['Cargo']
        puts " \\_ Carriage-number-#{index} #{carriage.class.to_s} volume_left:#{carriage.volume_left} occupaid_volume:#{carriage.occupaid_volume}"
      else
        puts " \\_ Carriage-number-#{index} #{carriage.class.to_s} free_seats:#{carriage.free_seats} occupied_seats:#{carriage.occupied_seats}"
      end
    end
  end
end

