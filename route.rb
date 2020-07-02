class Route

  attr_reader :stations

  def initialize(current_station, end_station)
    check_attributes_type(current_station, end_station)
    @stations = [current_station, end_station]
  end

  def add_station(station)
    @stations[-1,0] = station unless incorrect_station?(station)
  end

  def remove_station(station)
    @stations.delete(station) unless incorrect_station?(station)
  end

  def show_route
    @stations.map.with_index(1) { |station, index| [station.station_name, index] }.to_h
  end

  private # -------------------------------------------------------------------

  def is_a_station?(station)
    return true if station.is_a?(Station)
    raise TypeError.new "Not a Station class"
  end

  def check_attributes_type(*stations)
    stations.each { |station| is_a_station?(station) }
  end

  def first_or_last_station?(station)
    @stations.first == station || @stations.last == station
  end

  def incorrect_station?(station)
    !is_a_station?(station) || first_or_last_station?(station)
  end
end
