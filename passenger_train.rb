class PassengerTrain < Train
  def add_carriage(carriage)
    super if carriage.is_a?(PassengerCarriage)
  end
end
