class Carriage
  include Manufacturer
  include Validation
  extend Accessors

  attr_reader :free_space
  strong_attr_accessor :max_space,  Integer
  strong_attr_accessor :free_space, Integer

  validate :max_space, :presence
  validate :free_space, :presence

  def initialize(number)
    self.max_space = number
    self.free_space = number
    validate!
  end

  def space_left
    @max_space - @free_space
  end
end
