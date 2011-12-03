require "active_support/core_ext/module/aliasing"

module AttributeInheritance
  module ModelAdditions
    def attr_inherited(*attributes, options)
      accessor = options.fetch(:from)
      define_method :"#{accessor}_with_setting_defaults=" do |object|
        attributes.each do |attr|
          send(attr) || send("#{attr}=", object.send(attr))
        end if object
        send(:"#{accessor}_without_setting_defaults=", object)
      end
      alias_method_chain :"#{accessor}=", :setting_defaults
    end
  end
end
