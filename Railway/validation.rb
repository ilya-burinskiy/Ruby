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

      @is_vmethod_defined ||= {:precence => false, :format => false, :type => false}

      unless @is_vmethod_defined[vtype]
        case vtype
        when :precence
          define_precence_vmethod(vtype)
        when :format
          definde_format_vmethod(vtype)
        when :type
          define_type_vmethod(vtype)
        else
          raise 'Unknown validator type'
        end
        @is_vmethod_defined[vtype] = true
      end
    end

    attr_reader :vars_validators

    private

    def define_precence_vmethod(vtype)
      define_method("validate_#{vtype}".to_sym) do |var_name, vparam|
        if instance_variable_get("@#{var_name}".to_sym).nil?
          raise "@#{var_name} must have non nil value" 
        end
      end
    end

    def definde_format_vmethod(vtype)
      define_method("validate_#{vtype}".to_sym) do |var_name, format|
        if instance_variable_get("@#{var_name}".to_sym) !~ format
          raise "@#{var_name} does not match the format" 
        end
      end
    end

    def define_type_vmethod(vtype)
      define_method("validate_#{vtype}".to_sym) do |var_name, cls|
        if instance_variable_get("@#{var_name}".to_sym).class != cls 
          raise "@#{var_name} does not match the class"
        end
      end
    end

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
  
  end
  
end