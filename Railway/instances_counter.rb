module InstancesCounter

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances_number
    end

    protected
    def register_instance
      @instances_number = @instances_number.nil? ? 0 : @instances_number
      @instances_number += 1
    end
  end

  module InstanceMethods
    protected
    def register_instance
      self.class.send :register_instance
    end
  end
  
end