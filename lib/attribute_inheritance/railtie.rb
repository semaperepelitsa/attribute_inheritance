module AttributeInheritance
  class Railtie < ::Rails::Railtie

    initializer 'attribute_inheritance.model_additions' do
      ActiveSupport.on_load :active_record do
        extend ModelAdditions
      end
    end

  end
end
