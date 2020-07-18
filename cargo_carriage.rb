class CargoCarriage < Carriage
  
  def take_up_valume(num)
    return if @free_space == 0
    result = @free_space - num 
    @free_space = result if result.positive? || result == 0
  end
end
