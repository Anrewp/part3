class Station

  attr_reader :train_list, :station_name

  def initialize(station_name)
    @station_name = station_name
    @train_list = []
  end

  def acept_train(train)
    @train_list << train if train.is_a?(Train)
  end

  def send_train(train)
    @train_list.delete(train)
  end

  def train_list_by_type(train_type)
    { train_type => @train_list.select { |train| train.type == train_type }.size }
  end
end
