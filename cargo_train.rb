class CargoTrain < Train
  include ExceptionHendler

  def add_carriage(carriage)
    valid?('Type', !carriage.is_a?(CargoCarriage))
    super
  rescue TypeError => e
    rescue_info(e)
  end
end
