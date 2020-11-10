# frozen_string_literal: true

module InstancesCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances_number || 0
    end

    protected

    def register_instance
      @instances_number ||= 0
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
