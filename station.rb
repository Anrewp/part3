class Station
  include InstanceCounter
  include ExceptionHendler

  @@instances = []
  attr_reader :train_list, :station_name

  def initialize(station_name)
    valid?("Type", !station_name.is_a?(String))
    @station_name = station_name
    @train_list = []
    @@instances << self
    self.register_instance
  rescue TypeError => e
    rescue_info(e)
  end

  def accept_train(train)
    valid?("Type", !train.is_a?(Train))
    @train_list << train
  rescue TypeError => e
    rescue_info(e)
  end

  def send_train(train)
    @train_list.delete(train)
  end

  def train_list_by_type(class_name)
    { class_name.to_s => @train_list.select { |train| train.class == class_name }.size }
  end

  def self.all
    @@instances.inspect
  end
end
