class Route
  include InstanceCounter
  # include ExceptionHandler

  attr_reader :stations

  def initialize(current_station, end_station)
    valid?(current_station, end_station)
    @stations = [current_station, end_station]
    self.register_instance
  rescue TypeError => e
    rescue_info(e)
  end

  def add_station(station)
    valid_station?(station)
    @stations[-1,0] = station
  rescue TypeError => e
    rescue_info(e)
  end

  def remove_station(station)
    valid_station?(station)
    @stations.delete(station)
  rescue TypeError => e
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

  def valid?(current_station, end_station)
    raise TypeError.new "Not a station class" unless current_station.is_a?(Station) && end_station.is_a?(Station)
  end

  def valid_station?(station)
    raise TypeError.new "Not a station class" unless station.is_a?(Station) && !first_or_last_station?
    true
  end

  def rescue_info(error)
    puts " Rescued: Error: #{error.message}"
    error.backtrace.each { |trace| puts trace }
  end
end
