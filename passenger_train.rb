class PassengerTrain < Train
  @@instances = []

  def initialize(number)
    super(number)
    @@instances << self
  end

  def add_carriage(carriage)
    super if carriage.is_a?(PassengerCarriage)
  end

  def self.all
    @@instances
  end
end
