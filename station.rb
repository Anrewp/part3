class Station
  include InstanceCounter
  # include ExceptionHandler

  @@instances = []
  attr_reader :train_list, :station_name

  def initialize(station_name)
    valid?(station_name)
    @station_name = station_name
    @train_list = []
    @@instances << self
    register_instance
  end

  def accept_train(train)
    @train_list << train if valid_train?(train)
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

  private # ------------------------------------------------------

  def valid?(station_name)
    raise TypeError, 'Station name is not a string' unless station_name.is_a?(String)

    true
  end

  def valid_train?(train)
    raise TypeError, 'Not a train class!' unless train.is_a?(Train)

    true
  end
end
