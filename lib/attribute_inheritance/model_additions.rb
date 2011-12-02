require "active_support/core_ext/module/aliasing"

module AttributeInheritance
  module ModelAdditions
    def attr_inherited(association, *attributes)
      define_method :"#{association}_with_setting_defaults=" do |object|
        attributes.each do |attr|
          send(attr) || send("#{attr}=", object.send(attr))
        end if object
        send(:"#{association}_without_setting_defaults=", object)
      end
      alias_method_chain :"#{association}=", :setting_defaults
    end
  end
end
