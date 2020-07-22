class CargoTrain < Train
  # include ExceptionHandler

  def add_carriage(carriage)
    super if valid_carriage?(carriage)
  end

  private

  def valid_carriage?(carriage)
    raise TypeError.new "Not a CargoCarriage class!" unless carriage.is_a?(CargoCarriage)
    true
  end
end
