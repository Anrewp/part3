class Route
  include InstanceCounter
  include Validation

  attr_reader   :stations, :current_station, :end_station

  validate      :current_station, :type, Station
  validate      :end_station, :type, Station
  validate_type :station, 'Station'

  def initialize(current_station, end_station)
    @current_station = current_station
    @end_station = end_station
    validate!
    @stations = [current_station, end_station]
    register_instance
  end

  def add_station(station)
    @stations[-1, 0] = station if correct_station?(station)
  end

  def remove_station(station)
    @stations.delete(station) if correct_station?(station)
  end

  def show_route
    @stations.map.with_index(1) { |station, index| [station.station_name, index] }.to_h
  end

  private # -------------------------------------------------------------------

  def first_or_last_station?(station)
    [@stations.first, @stations.last].include?(station)
  end

  def correct_station?(station)
    valid_station_class?(station) && !first_or_last_station?(station)
  end
end
