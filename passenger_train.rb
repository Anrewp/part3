class PassengerTrain < Train
  validate_type :carriage, 'PassengerCarriage'

  def add_carriage(carriage)
    super if valid_carriage_class?(carriage)
  end
end
