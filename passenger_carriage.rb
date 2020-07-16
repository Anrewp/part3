class PassengerCarriage < Carriage

  attr_reader :free_seats

  def initialize(number_of_seats)
    @number_of_seats = number_of_seats
    @free_seats = number_of_seats
  end

  def take_a_seat
    @free_seats -= 1 if @free_seats != 0
  end

  def occupied_seats
    @number_of_seats - @free_seats
  end

end
