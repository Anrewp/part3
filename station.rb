class Station
  include InstanceCounter
  include Validation
  extend  Accessors

  @@instances = []
  attr_reader :train_list
  strong_attr_accessor :station_name, String

  validate :station_name, :precense
  validate_type :train, 'Train'

  def initialize(station_name)
    self.station_name = station_name
    validate!
    @train_list = []
    @@instances << self
    register_instance
  end

  def accept_train(train)
    @train_list << train if valid_train_class?(train)
  end

  def send_train(train)
    @train_list.delete(train)
  end

  def train_list_by_type(class_name)
    { class_name.to_s => @train_list.select { |train| train.class == class_name }.size }
  end

  def self.all
    @@instances
  end

  def each_train_to_block_with_index(train_index = 0, &block)
    return unless block_given?

    @train_list.each.with_index(train_index) { |train, index| block.call(train, index) }
  end
end
