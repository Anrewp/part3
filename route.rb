class Route

  attr_reader :passing_stations_list

  def initialize(current_station, end_station)
    @current_station = current_station if station?(current_station)
    @end_station = end_station if station?(end_station)
    @passing_stations_list = [current_station, end_station]
  end

  def add_passing_station(station)
    station?(station)
    @passing_stations_list[-1,0] = station
  end

  def remove_passing_station(station)
    station?(station)
    @passing_stations_list.delete(station)
  end

  def show_route
    @passing_stations_list.map.with_index { |station, index| [station.station_name, index + 1] }.to_h
  end

  private

  def station?(station)
    return true if station.is_a?(Station)
    raise TypeError.new "Not a Station class"
  end
end
