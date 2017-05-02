module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, attrs)
      @validations ||= {}
      @validations[name] ||= []
      @validations[name] << attrs
    end
  end

  module InstanceMethods
    def validate!
      validations = self.class.validations

      validations.each do |attr_name, rules_array|
        attr_value = instance_variable_get("@#{attr_name}")
        rules_array.each do |rules_hash|
          rules_hash.each { |action, rule| send(action.to_sym, attr_value, rule) }
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

    def presence(attribute, *)
      raise "value couldn't be blank" if !attribute || attribute.empty?
    end

    def attr_type(attribute, type)
      raise "#{attribute} doesn't belong to the #{type}" unless attribute.instance_of?(type)
    end

    def format(attribute, exp)
      raise "#{attribute} wrong format" if attribute !~ exp
    end
  end
end