class Interface

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def run
    loop do

      puts "- - - - - - - - - - - - - - - - - - - - - - - -"
      puts " --- CREATE ---"
      puts "Choose 1  to create station"
      puts "Choose 2  to create train"
      puts "Choose 3  to create route"
      puts ""
      puts " --- ADD/REMOVE ---"
      puts "Choose 4  to add station to route"
      puts "Choose 5  to remove station from route"
      puts "Choose 6  to assign train to route"
      puts ""
      puts "Choose 7  to add carriage to train"
      puts "Choose 8  to remove carriage from train"
      puts "Choose 9  take up a seat in passenger train carriage"
      puts "Choose 10 take up volume of  cargo train carriage"
      puts ""
      puts " --- TRANSFER ---"
      puts "Choose 11 to transfer train to the next stations"
      puts "Choose 12 to transfer train to the previous stations"
      puts ""
      puts " --- INFO ---"
      puts "Choose 13 to Show all stations"
      puts "Choose 14 to Show all trains on station"
      puts "Choose 15 to Show train carriages"
      puts "- - - - - - - - - - - - - - - - - - - - - - - -"
      option = gets.chomp.to_i

      case option
      when 1  then create_station
      when 2  then create_train
      when 3  then create_route
      when 4  then add_station_to_route
      when 5  then remove_station_from_route
      when 6  then assign_train_to_route
      when 7  then add_carriage_to_train
      when 8  then remove_carriage_from_train
      when 9  then take_a_seat
      when 10 then take_up_carriage_volume
      when 11 then move_train_to_the_next_station
      when 12 then move_train_to_the_previous_station
      when 13 then show_all_stations
      when 14 then show_all_trains_on_station
      when 15 then show_train_carriages
      else break
      end

    end
  end

  private


# ######### ███╗░░░███╗░█████╗░██╗███╗░░██╗ #########
# ######### ████╗░████║██╔══██╗██║████╗░██║ #########
# ######### ██╔████╔██║███████║██║██╔██╗██║ #########
# ######### ██║╚██╔╝██║██╔══██║██║██║╚████║ #########
# ######### ██║░╚═╝░██║██║░░██║██║██║░╚███║ #########
# ######### ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝╚═╝░░╚══╝ #########

# __________ CREATE [ROUTE TRAIN STATION]  _____________
# ______________________________________________________

  def create_station
    puts "Add station name: "
    @stations << Station.new(gets.chomp.to_s)
    press_enter_to_continue
  end

  def create_train
    puts "Enter train number: "
    number = gets.chomp.to_s
    puts "Train types: "
    puts "enter 1 for Cargo Train"
    puts "enter 2 for Passenger Train"
    result = gets.chomp.to_i

    case result
    when 1 then @trains << CargoTrain.new(number)
    when 2 then @trains << PassengerTrain.new(number)
    else return
    end
    press_enter_to_continue
  end

  def create_route
    available_stations
    first_station = @stations[gets.chomp.to_i]
    return unless first_station
    available_stations
    second_station = @stations[gets.chomp.to_i]
    return unless second_station
    @routes << Route.new(first_station, second_station)
    press_enter_to_continue
  end

  # __________________ ADD REMOVE STATION ________________
  # ______________________________________________________

  def add_station_to_route
    route, station = choose_route_and_station
    route.add_station(station)
    press_enter_to_continue
  end

  def remove_station_from_route
    route, station = choose_route_and_station
    route.remove_station(station)
    press_enter_to_continue
  end

  # __________________ TRAIN/ROUTE _______________________
  # ______________________________________________________

  def assign_train_to_route
    available_routes
    r = @routes[gets.chomp.to_i]
    t = find_train
    t.initialize_route(r)
    press_enter_to_continue
  end

  # __________________ CARRIAGE __________________________
  # ______________________________________________________


  def add_carriage_to_train
    t = find_train
    c = if t.class.to_s['Cargo']
          puts "Enter carriage volume"
          CargoCarriage.new(gets.chomp.to_i)
        else
          puts "Enter carriage available seats number"
          PassengerCarriage.new(gets.chomp.to_i)
        end
    t.add_carriage(c)
    press_enter_to_continue
  end

  def remove_carriage_from_train
    t = find_train
    available_info('carriage')
    t.carriages.each_with_index { |carriage, index| puts "#{carriage} - #{index}" }
    choose_info('carriage')
    help_info
    c = t.carriages[gets.chomp.to_i]
    t.remove_carriage(c)
    press_enter_to_continue
  end

  def take_a_seat
    c = find_train_carriage('Passenger')
    c.take_a_seat
  end

  def take_up_carriage_volume
    c = find_train_carriage('Cargo')
    puts "Enter volume"
    c.take_up_valume(gets.chomp.to_i)
  end

  # __________________ TRANSFER __________________________
  # ______________________________________________________

  def move_train_to_the_next_station
    t = find_train
    t.move_to_the_next_station
    press_enter_to_continue
  end

  def move_train_to_the_previous_station
    t = find_train
    t.move_to_the_previous_station
    press_enter_to_continue
  end

  # __________________ SHOW INFORMATION __________________
  # ______________________________________________________

  def show_all_stations
    @stations.each_with_index { |station, index| puts "#{station.station_name} - #{index}" }
    press_enter_to_continue
  end

  def show_all_trains_on_station
    available_stations
    station = get_station(gets.chomp.to_i)
    station.each_train_to_block_with_index(1) { |train, index| puts "#{train.number} - #{index}" }
    press_enter_to_continue
  end

  def show_train_carriages
    t = find_train
    t.each_carriage_to_block_with_index(1) do |carriage, index|
      puts "#{t.number} - #{t.class.to_s}"
      if carriage.class.to_s['Cargo']
        puts " \\_ Carriage-number-#{index} #{carriage.class.to_s} volume_left:#{carriage.free_space} occupaid_volume:#{carriage.space_left}"
      else
        puts " \\_ Carriage-number-#{index} #{carriage.class.to_s} free_seats:#{carriage.free_space} occupied_seats:#{carriage.space_left}"
      end
    end
    press_enter_to_continue
  end

  # ______________________________________________________
  # ______________________________________________________

  
# ######### ██╗░░██╗███████╗██╗░░░░░██████╗░ #########
# ######### ██║░░██║██╔════╝██║░░░░░██╔══██╗ #########
# ######### ███████║█████╗░░██║░░░░░██████╔╝ #########
# ######### ██╔══██║██╔══╝░░██║░░░░░██╔═══╝░ #########
# ######### ██║░░██║███████╗███████╗██║░░░░░ #########
# ######### ╚═╝░░╚═╝╚══════╝╚══════╝╚═╝░░░░░ #########


  def help_info
    puts "(Enter number from above list)"
  end

  def available_info(type)
    puts "Available #{type}s are next: "
  end

  def choose_info(type)
    puts "Choose #{type}: "
  end

  def get_station(index)
    @stations[index]
  end

  def press_enter_to_continue
    puts "Press Enter to continue"
    gets
  end

  def available_stations
    available_info('station')
    @stations.each_with_index { |station, index| puts "#{station.station_name} - #{index}" }
    choose_info('station')
    help_info
  end

  def available_routes
    available_info('route')
    @routes.each_with_index { |station, index| puts "Route - #{index}" }
    choose_info('route')
    help_info
  end

  def choose_route_and_station
    available_routes
    r = @routes[gets.chomp.to_i]
    available_stations
    s = @stations[gets.chomp.to_i]
    [r, s]
  end

  def find_train(type = nil)
    available_info('train')
    if type
      @trains.each_with_index { |train, index| puts "#{train.class} number: #{train.number} - #{index}" if train.class.to_s[type] }
    else
      @trains.each_with_index { |train, index| puts "#{train.class} number: #{train.number} - #{index}" }
    end
    choose_info('train')
    help_info
    @trains[gets.chomp.to_i]
  end

  def find_train_carriage(type)
    t = find_train(type)
    available_info('carriage')
    t.carriages.each_with_index { |carriage, index| puts "#{carriage} - #{index}" if t.class.to_s[type] }
    choose_info('carriage')
    help_info
    t.carriages[gets.chomp.to_i]
  end
end
