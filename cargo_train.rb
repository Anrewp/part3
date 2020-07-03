class CargoTrain < Train
  @@instances = []
  
  def initialize(number)
    super(number)
    @@instances << self
  end

  def add_carriage(carriage)
    super if carriage.is_a?(CargoCarriage)
  end

  def self.all
    @@instances
  end
end
