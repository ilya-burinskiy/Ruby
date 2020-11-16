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
          case vtype
          when :precence
            validate_precence(var_name)
          when :format
            validate_format(var_name, vparam)
          when :type
            validate_type(var_name, vparam)
          else
            raise 'Unknown validator type'
          end
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

    def validate_precence(var_name)
      raise "@#{var_name} must have non nil value" if instance_variable_get("@#{var_name}".to_sym).nil?
    end

    def validate_format(var_name, format)
      raise "@#{var_name} does not match the format" if instance_variable_get("@#{var_name}".to_sym) !~ format 
    end

    def validate_type(var_name, cls)
      if instance_variable_get("@#{var_name}".to_sym).class != cls 
        raise "@#{var_name} does not match the class"
      end
    end
  
  end
end
