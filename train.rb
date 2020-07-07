class Train
  include Manufacturer
  include InstanceCounter

  @@instances = []
  attr_reader :speed, :number, :carriages

  def initialize(train_number)
    @number = train_number.to_s
    @speed = 0
    @carriages = []
    @@instances << self
    self.register_instance
  end

  def initialize_route(route)
    return unless route.is_a?(Route)
    @route = route
    @route.stations.first.acept_train(self)
    @station_index = 0
  end

  # - - - - - - - - - SPEED - - - - - - - - - - - - - 

  def increase_speed_by(num)
    @speed += num
  end

  def stop
    @speed = 0
  end

  # - - - - - - - -  CARRIAGE - - - - - - - - - - - - - 

  def add_carriage(carriage)
    @carriages << carriage if @speed == 0
  end

  def remove_carriage(carriage)
    @carriages.delete(carriage) if @speed == 0 && @carriages.size != 0
  end

  # - - - - - - - -  STATIONS  - - - - - - - - - - - - - 
  
  def current_station
    @route.stations[@station_index]
  end

  def next_station
    @route.stations[@station_index + 1]
  end

  def previous_station
    return if @station_index == 0
    @route.stations[@station_index - 1]
  end

  # - - - - - - - -  TRANSFER  - - - - - - - - - - - - - 

  def move_to_the_next_station
    move_between_stations('next_station')
  end

  def move_to_the_previous_station
    move_between_stations('previous_station')
  end

  # - - - - - - - -  GLOBAL  - - - - - - - - - - - - - 

  def self.find(number)
    @@instances.find { |train| train.number == number }
  end

  protected # ------------------------------------------

  # Может быть использован потомками 
  def move_between_stations(next_or_previous_station)
    station = self.send(next_or_previous_station)
    return unless station
    self.current_station.send_train(self)
    station.acept_train(self)
    op = next_or_previous_station == 'next_station' ? '+' : '-'
    @station_index = @station_index.send(op, 1)
  end
end
