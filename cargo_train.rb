class CargoTrain < Train
  # include ExceptionHandler

  def add_carriage(carriage)
    super if valid_carriage?(carriage)
  rescue TypeError => e
    rescue_info(e)
  end

  def valid_not_empty?
    !self.instance_variables.empty?
  end

  private 

  def valid_carriage?(carriage)
    raise TypeError.new "Not a CargoCarriage class!" unless carriage.is_a?(CargoCarriage)
  end

  def rescue_info(error)
    puts " Rescued: Error: #{error.message}"
    error.backtrace.each { |trace| puts trace }
  end
end
