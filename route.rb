class Route
  include InstanceCounter
  # include ExceptionHandler

  attr_reader :stations

  def initialize(current_station, end_station)
    valid?(current_station, end_station)
    @stations = [current_station, end_station]
    register_instance
  end

  def add_station(station)
    valid_station?(station)
    @stations[-1, 0] = station
  end

  def remove_station(station)
    valid_station?(station)
    @stations.delete(station)
  end

  def show_route
    @stations.map.with_index(1) { |station, index| [station.station_name, index] }.to_h
  end

  private # -------------------------------------------------------------------

  def first_or_last_station?(station)
    [@stations.first, @stations.last].include?(station)
  end

  def incorrect_station?(station)
    !station.is_a?(Station) || first_or_last_station?(station)
  end

  def valid?(current_station, end_station)
    raise TypeError, 'Not a station class' unless current_station.is_a?(Station) && end_station.is_a?(Station)

    true
  end

  def valid_station?(station)
    raise TypeError, 'Not a station class' unless station.is_a?(Station) && !first_or_last_station?(station)

    true
  end
end
