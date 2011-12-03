module Mongoid
  module Document
    module ClassMethods
      include AttributeInheritance::ModelAdditions
    end
  end
end
