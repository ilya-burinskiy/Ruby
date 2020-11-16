module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}"
      var_history = "@#{name}_history"

      define_method(name) { instance_variable_get(var_name.to_sym) }

      define_method("#{name}_history".to_sym) { instance_variable_get(var_history.to_sym) }

      define_method("#{name}=".to_sym) do |val|
        instance_variable_set(var_history.to_sym, []) if instance_variable_get(var_history.to_sym).nil?
        curr_var_value = instance_variable_get(var_name.to_sym)
        instance_variable_get(var_history.to_sym) << curr_var_value unless curr_var_value.nil?
        instance_variable_set(var_name.to_sym, val)
      end
    end
  end

  def strong_attr_accessor(name, type)
    var_name = "@#{name}"
    @vars_types ||= {}
    @vars_types[name] = type

    define_method(name.to_sym) { instance_variable_get(var_name.to_sym) }

    define_method("#{name}=") do |val|
      if val.class != self.class.var_type(name)
        raise "Wrong class for #{var_name}. Expected #{self.class.var_type(name)}, given #{val.class}"
      end

      instance_variable_set(var_name.to_sym, val)
    end
  end

  def var_type(name)
    @vars_types[name]
  end
end
