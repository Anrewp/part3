module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    ERR_MSG_FORMAT = ' -- Does not match regular expression foramt!'.freeze
    ERR_MSG_TYPE   = ' -- Class type is incorrect!'.freeze
    ERR_MSG_ATTR   = ' -- Attribute is not present!'.freeze

    def validate(attr_name, validation_type, utility = nil)
      case validation_type
      when :presence
        define_method("#{attr_name}_presence_validate") do
          raise ArgumentError, attr_name.to_s + ERR_MSG_ATTR if send(attr_name).nil? || send(attr_name).to_s.empty?
        end

      when :format
        define_method("#{attr_name}_format_validate") do
          raise RegexpError, attr_name.to_s + ERR_MSG_FORMAT if send(attr_name) !~ utility
        end

      when :type
        define_method("#{attr_name}_type_validate") do
          raise TypeError, attr_name.to_s + ERR_MSG_TYPE unless send(attr_name).is_a?(utility)
        end
      end
    end

    def validate_type(attr_name, class_type)
      define_method("valid_#{attr_name}_class?") do |attribute|
        raise TypeError, attr_name.to_s + ERR_MSG_TYPE unless attribute.class.to_s[class_type]

        true
      end
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError => e
      puts " Validatoin Failed: Error: #{e.message}"
      false
    end

    private

    def validate!
      validation_methods = methods.grep(/_(presence|format|type)_validate/)
      validation_methods.each { |validatoin_method| send(validatoin_method) }
    end
  end
end
