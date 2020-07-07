module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.instance_eval { @instances = 0 }
  end
  
  module ClassMethods
    attr_accessor :instances

    def inherited(subclass)
      subclass.instance_eval do
        @instances = 0
      end
    end
    
    def increment
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
