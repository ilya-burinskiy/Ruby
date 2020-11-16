module Validation
  module ClassMethods
    def validate(name, vtype, vparam = nil)
      @vars_validators ||= {}
      @vars_validators[name] ||= []
      @vars_validators[name] << { vtype: vtype, vparam: vparam }
    end

    def vars_validators
      @vars_validators
    end
  end

  module InstanceMethods
    def validate!
      self.class.vars_validators.each do |var_name, validators_params_list|
        validators_params_list.each do |validator_params|
          vtype = validator_params[:vtype]
          vparam = validator_params[:vparam]
          case vtype
          when :precence
            raise "@#{var_name} must have non nil value" if instance_variable_get("@#{var_name}".to_sym).nil?
          when :format
            raise "@#{var_name} does not match the format" if instance_variable_get("@#{var_name}".to_sym) !~ vparam
          when :type
            if instance_variable_get("@#{var_name}".to_sym).class != vparam 
              raise "@#{var_name} does not match the class"
            end
          else
            raise 'Unknown validator type'
          end
        end
      end
    end
  end
end
