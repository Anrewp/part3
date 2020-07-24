class CargoCarriage < Carriage
  def take_up_valume(num)
    return if @free_space.zero?

    result = @free_space - num
    @free_space = result if result.positive? || result.zero?
  end
end
