# Overrides model `new` class method with the one that takes into account `type` attribute and initializes object
# of the corresponding class. That module should be included into the base class of the classes hierarchy that shares
# the same table via STI mechanism.
#
module STITypeCasting

  # Include hook that defines `klass_by_type` method in the hierarchy base class and adds alias method chain for
  # `new_with_cast` method.
  #
  def self.included(base)
    base.extend ClassMethods
    base.singleton_class.alias_method_chain :new, :cast

    base.singleton_class.class_eval <<-END, __FILE__, __LINE__ + 1
      def klass_by_type(type)
        klass = type && type.to_s.constantize rescue nil
        raise ArgumentError.new("Type \#{type.inspect} should be a subclass of #{base.to_s}.") unless klass.present? && klass < #{base.to_s}
        klass
      end

      def inherited(child)
        child.instance_eval do
          alias :original_model_name :model_name

          def model_name
            #{base.to_s}.model_name
          end
        end
        super
      end
    END
  end

  # Updates `type` attribute if `value` is a valid class name.
  #
  def type=(value)
    write_attribute(:type, value) if self.class.klass_by_type(value)
  end

  module ClassMethods
    # If `type` attribute is passed and its value is a valid name of a class from the same hierarchy then an instance
    # of that class is returned instead of an instance of the class the method is called on.
    #
    def new_with_cast(*args, &block)
      type = args.first.is_a?(Hash) && args.first.with_indifferent_access[inheritance_column]

      if type.present?
        klass = klass_by_type(type)
        klass.new_without_cast(*args, &block)
      else
        new_without_cast(*args, &block)
      end
    end

    # Overrides default implementation to allow mass-assignment of inheritance_column attribute (`type` attribute
    # by default).
    #
    def attributes_protected_by_default
      super - [inheritance_column]
    end
  end
end
