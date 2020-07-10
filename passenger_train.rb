class PassengerTrain < Train
  include ExceptionHendler

  def add_carriage(carriage)
    valid?('Type', !carriage.is_a?(PassengerCarriage))
    super
  rescue TypeError => e
    rescue_info(e)
  end
end
