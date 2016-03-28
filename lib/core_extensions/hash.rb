module CoreExtensions
  module Hash
    module Attributes
      module CleanOrEmpty
        String.include CoreExtensions::String::Numeric
        Symbol.include CoreExtensions::Symbol::ToFoo

        def clean_or_empty?(association)
          association_class = association.to_c
          default_attributes = association_class.new

          # return false if any values have been changed from default
          each do |key, value|
            next unless association_class.column_names.include? key
            clean_value = clean_attribute(value)
            return false if clean_value != default_attributes[key]
          end

          true
        end

        def clean_attribute(attribute)
          if attribute == ''
            attribute = nil
          elsif attribute.numeric?
            attribute = attribute.to_f
          end
          attribute
        end
      end
    end
  end
end
