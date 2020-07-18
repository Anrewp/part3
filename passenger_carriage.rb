class PassengerCarriage < Carriage

  def take_a_seat
    @free_space -= 1 if @free_space != 0
  end
end
