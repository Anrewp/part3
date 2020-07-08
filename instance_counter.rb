module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    attr_accessor :instances

    def increment
      self.instances ||= 0
      self.instances += 1
    end
  end
  
  module InstanceMethods
    protected
    def register_instance
      self.class.increment
    end
  end

end
