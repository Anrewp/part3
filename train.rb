
class Train
  TYPES = %w[freight passenger].freeze

  attr_reader :speed, :carriage_size, :type, :number, :index

  def initialize(train_number, train_type, carriage_size)
    @number = train_number.to_s
    @type = train_type if correct_type?(train_type)
    @carriage_size = carriage_size
    @speed = 0
  end

  def initialize_route(route)
    return unless route.is_a?(Route)
    @route = route
    @route.passing_stations_list.first.acept_train(self)
    @station_index = 0
  end

  def increase_speed_by(num)
    @speed = num
  end

  def stop
    @speed = 0
  end

  def add_remove_carriage(op)
    check_op(op)
    @carriage_size = @carriage_size.send("#{op}", 1) if @speed == 0
  end

  def current_station
    @route.passing_stations_list[@station_index]
  end

  def next_station
    @route.passing_stations_list[@station_index + 1]
  end

  def previous_station
    return if @station_index == 0
    @route.passing_stations_list[@station_index - 1]
  end

  def move_to_the_next_station
    move_between_stations('next_station')
  end

  def move_to_the_previous_station
    move_between_stations('previous_station')
  end

  private

  def move_between_stations(next_or_previous_station)
    station = self.send(next_or_previous_station)
    return unless station
    self.current_station.send_train(self)
    station.acept_train(self)
    op = next_or_previous_station == 'next_station' ? '+' : '-'
    @station_index = @station_index.send(op, 1)
  end

  def correct_type?(train_type)
    return true if TYPES.include?(train_type)
    raise TypeError.new 'Thre is no such train type' 
  end

  def check_op(op)
    raise ArgumentError.new 'No such operation. You can use only + or -' unless %w[+ -].include?(op)
  end
end


class FreightTrain < Train; end
class PassangerTrain < Train; end
