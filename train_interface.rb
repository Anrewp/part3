class TrainInterface
  def run
    loop do
      break if press_enter_to_continue['0']

      number = input_train_number
      result = choose_train_type
      case result
      when 1 then  CargoTrain.new(number)
      when 2 then  PassengerTrain.new(number)
      else raise StandardError, 'No such option try again'
      end
      success
    end
  rescue StandardError => e
    rescue_info(e)
    retry
  end

  private # ----------------------------------------

  def success
    puts 'Train successfully created!'
  end

  def press_enter_to_continue
    puts 'Press enter to create train or 0 to exit'
    gets.chomp
  end

  def input_train_number
    puts 'Enter train number: '
    gets.chomp.to_s
  end

  def choose_train_type
    puts 'Train types: '
    puts 'enter 1 for Cargo Train'
    puts 'enter 2 for Passenger Train'
    gets.chomp.to_i
  end

  def rescue_info(error)
    puts " Rescued: Error: #{error.message}"
    error.backtrace.each { |trace| puts trace }
  end
end
