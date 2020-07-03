class Route
  @@instances = []

  attr_reader :stations

  def initialize(current_station, end_station)
    is_a_stations?(current_station, end_station)
    @stations = [current_station, end_station]
    @@instances << self
  end

  def add_station(station)
    @stations[-1,0] = station if correct_station?(station)
  end

  def remove_station(station)
    @stations.delete(station) if correct_station?(station)
  end

  def show_route
    @stations.map.with_index(1) { |station, index| [station.station_name, index] }.to_h
  end

  def self.all
    @@instances
  end

  def self.get_route(index)
    @@instances[index]
  end

  private # -------------------------------------------------------------------
  # Методы используются только самим классом Route

  def is_a_station?(station)
    return true if station.is_a?(Station)
    raise TypeError.new "Not a Station class"
  end

  def is_a_stations?(*stations)
    stations.each { |station| is_a_station?(station) }
  end

  def first_or_last_station?(station)
    @stations.first == station || @stations.last == station
  end

  def correct_station?(station)
    is_a_station?(station) && !first_or_last_station?(station)
  end
end
