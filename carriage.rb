class Carriage
  include Manufacturer

  attr_reader :free_space

  def initialize(number)
    @max_space = number
    @free_space = number
  end

  def space_left
    @max_space - @free_space
  end
end
