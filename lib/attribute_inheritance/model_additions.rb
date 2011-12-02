require "active_support/core_ext/module/aliasing"

module AttributeInheritance
  module ModelAdditions
    def attr_inherited(association, *attributes)
      define_method :"#{association}_with_setting_defaults=" do |object|
        attributes.each do |attr|
          public_send(attr) || public_send("#{attr}=", object.public_send(attr))
        end if object
        public_send(:"#{association}_without_setting_defaults=", object)
      end
      alias_method_chain :"#{association}=", :setting_defaults
    end
  end
end
