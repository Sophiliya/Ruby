module InstanceCounter
  module ClassMethods
    attr_accessor :instances

    def show_instances_list(instances_array, attribute_name)
      instances_array.each.with_index(1) do |instance, index|
        puts "#{index}. #{instance.class}: #{instance.send(attribute_name)}"
      end
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end
