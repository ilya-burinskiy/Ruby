module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    def validate(name, vtype, vparam = nil)
      @vars_validators ||= {}
      @vars_validators[name] ||= []
      @vars_validators[name] << { vtype: vtype, vparam: vparam }
    end

    attr_reader :vars_validators
  end

  module InstanceMethods
    def validate!
      self.class.vars_validators.each do |var_name, validators_params_list|
        validators_params_list.each do |validator_params|
          vtype = validator_params[:vtype]
          vparam = validator_params[:vparam]
          send("validate_#{vtype}", var_name, vparam)
        end
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end
    
    private

    def validate_precence(var_name, vparam)
      if instance_variable_get("@#{var_name}".to_sym).nil?
        raise "@#{var_name} must have non nil value" 
      end
    end

    def validate_format(var_name, vparam)
      if instance_variable_get("@#{var_name}".to_sym) !~ vparam 
        raise "@#{var_name} does not match the format" 
      end
    end

    def validate_type(var_name, vparam)
      if instance_variable_get("@#{var_name}".to_sym).class != vparam
        raise "@#{var_name} does not match the class"
      end
    end
  end

end