class Route
  include InstanceCounter
  include ExceptionHendler

  attr_reader :stations

  def initialize(current_station, end_station)
    valid?('Type', !(current_station.is_a?(Station) && end_station.is_a?(Station)) )
    @stations = [current_station, end_station]
    self.register_instance
  rescue TypeError => e
    rescue_info(e)
  end

  def add_station(station)
    valid?('Data', incorrect_station?(station))
    @stations[-1,0] = station
  rescue IncorrectData => e
    rescue_info(e)
  end

  def remove_station(station)
    valid?('Data', incorrect_station?(station))
    @stations.delete(station)
  rescue IncorrectData => e
    rescue_info(e)
  end

  def show_route
    @stations.map.with_index(1) { |station, index| [station.station_name, index] }.to_h
  end

  private # -------------------------------------------------------------------

  def first_or_last_station?(station)
    @stations.first == station || @stations.last == station
  end

  def incorrect_station?(station)
    !station.is_a?(Station) || first_or_last_station?(station)
  end
end
