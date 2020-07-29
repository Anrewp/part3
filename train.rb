class Train
  include Manufacturer
  include InstanceCounter
  include Validation
  extend  Accessors

  NUMBER_FORMAT = /^[a-z|0-9]{3}-?[a-z|0-9]{2}$/i.freeze
  @@instances = {}

  attr_reader :speed, :number, :carriages
  strong_attr_accessor :route, Route

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(train_number)
    @number = train_number
    validate!
    @speed = 0
    @carriages = []
    @@instances[@number] = self
    register_instance
  end

  def initialize_route(route)
    self.route = route
    @route.stations.first.accept_train(self)
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
    @carriages << carriage if @speed.zero?
  end

  def remove_carriage(carriage)
    @carriages.delete(carriage) if @speed.zero? && !@carriages.empty?
  end

  def each_carriage_to_block_with_index(carriage_index = 0, &block)
    return unless block_given?

    @carriages.each.with_index(carriage_index) { |carriage, index| block.call(carriage, index) }
  end

  # - - - - - - - -  STATIONS  - - - - - - - - - - - - -

  def current_station
    @route.stations[@station_index]
  end

  def next_station
    @route.stations[@station_index + 1]
  end

  def previous_station
    return if @station_index.zero?

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
    @@instances[number]
  end

  protected # ------------------------------------------

  def move_between_stations(next_or_previous_station)
    station = send(next_or_previous_station)
    return unless station

    current_station.send_train(self)
    station.accept_train(self)
    op = next_or_previous_station == 'next_station' ? '+' : '-'
    @station_index = @station_index.send(op, 1)
  end
end
