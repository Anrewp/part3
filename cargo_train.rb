class CargoTrain < Train
  validate_type :carriage, 'CargoCarriage'

  def add_carriage(carriage)
    super if valid_carriage_class?(carriage)
  end
end
