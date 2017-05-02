module Accessors
  def attr_accessor_with_history(*attrs)
    attrs.each do |attr|
      attr_name = "#{attr}".to_sym
      values = []
      define_method(attr.to_sym) { instance_variable_get(attr_name) }

      attr_history = "#{attr_name}_history"

      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(attr_name, value)
        instance_variable_set(attr_history.to_sym, values << value) if instance_variable_defined?(attr_name)
      end

      define_method("#{name}_history".to_sym) { instance_variable_get(attr_history.to_sym) }
    end
  end

  def strong_attr_accessor(*attrs)
    attrs.each do |attr, type|
      define_method(attr.to_sym) { instance_variable_get("@#{attr}".to_sym) }

      define_method("#{attr}=".to_sym) do |value|
        if value.instance_of?(type)
          instance_variable_set("@#{attr}".to_sym, value)
        else
          raise "Wrong object type. @#{attr} should belong to #{type}"
        end
      end
    end
  end
end