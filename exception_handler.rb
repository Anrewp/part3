module ExceptionHandler
  ERR_MSG_FORMAT = 'Does not match regular expression foramt!'
  ERR_MSG_TYPE = 'Class type is incorrect!'
  ERR_MSG_DATA = 'Data is incorrect!'
  
  def valid?(type_error, condition)
    case type_error
    when 'Regexp'  then raise RegexpError.new    ERR_MSG_FORMAT if condition
    when 'Type'    then raise TypeError.new      ERR_MSG_TYPE   if condition
    when 'Data'    then raise IncorrectData.new  ERR_MSG_DATA   if condition
    end
    true
  end

  def rescue_info(error)
    puts " Rescued: Error: #{error.message}"
    error.backtrace.each { |trace| puts trace }
  end

  def valid_not_empty?
    !self.instance_variables.empty?
  end

  class IncorrectData < StandardError ; end
  class OptionError < StandardError ; end
end
