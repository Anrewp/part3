class Station

  attr_reader :train_list, :station_name

  def initialize(station_name)
    @station_name = station_name
    @train_list = []
  end

  def acept_train(train)
    return unless train.is_a?(Train)
    @train_list << train
  end

  def send_train(train)
    return unless train.is_a?(Train)
    @train_list.delete(train)
  end

  def train_list_by_type
    @train_list.group_by { |train| train.type }.map { |type, trains| [type, trains.size] }
  end
end
