class CargoCarriage < Carriage
  
  attr_reader :volume_left
  
  def initialize(volume)
    @volume_left = volume
    @capacity = volume
  end

  def take_up_valume(num)
    return if @volume_left == 0
    result = @volume_left - num 
    @volume_left = result if result.positive? || result == 0
  end

  def occupaid_volume
    @capacity - @volume_left
  end

end
