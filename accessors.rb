module Accessors
  def attr_accessor_with_history(*attributes)
    attributes.each do |attribute|
      attr_name = "@#{attribute}".to_sym
      attr_history = "@#{attribute}_history".to_sym
      define_method(attribute) { instance_variable_get(attr_name) }
      define_method("#{attribute}_history") { instance_variable_get(attr_history) }
      define_method("#{attribute}=") do |value|
        if instance_variable_get(attr_history)
          instance_variable_get(attr_history).push(instance_variable_get(attr_name))
        else
          instance_variable_set(attr_history, [])
        end
        instance_variable_set(attr_name, value)
      end
    end
  end

  def strong_attr_accessor(attr_name, attr_class)
    attribute = "@#{attr_name}".to_sym
    define_method(attr_name) { instance_variable_get(attribute) }
    define_method("#{attr_name}=") do |value|
      raise TypeError, "#{attr_name} -- Class type is incorrect!" unless value.is_a?(attr_class)

      instance_variable_set(attribute, value)
    end
  end
end
