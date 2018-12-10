module InstanceCounter
  module ClassMethods

    def instances
      self.all.length
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.all << self
    end
  end
end
