module InstancesKeeper

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @@instances = {}
    def instances
      @@instances
    end

    protected
    def add_instance(key, obj)
      @@instances[key] = obj
    end
  end

  module InstanceMethods
    protected
    def add_instance(key, obj)
      self.class.send(:add_instance, key, obj)
    end
  end

end
