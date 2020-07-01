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
    @stations.map.with_index { |station, index| [station.station_name, index + 1] }.to_h
  end

  private # -------------------------------------------------------------------

  def obj_is_a_station?(obj)
    return true if obj.is_a?(Station)
    raise TypeError.new "Not a Station class"
  end

  def check_attributes_type(*objects)
    objects.each { |obj| obj_is_a_station?(obj) }
  end

  def first_or_last_station?(station)
    @stations.first == station || @stations.last == station
  end

  def incorrect_station?(station)
    !obj_is_a_station?(station) || first_or_last_station?(station)
  end
end
