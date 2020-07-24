class PassengerTrain < Train
  # include ExceptionHandler

  def add_carriage(carriage)
    super if valid_carriage?(carriage)
  end

  private

  def valid_carriage?(carriage)
    raise TypeError, 'Not a PassengerCarriage class' unless carriage.is_a?(PassengerCarriage)

    true
  end
end
