module InstancesKeeper

  module ClassMethods

    def instances
      @instances || []
    end

    def add_instance(obj)
      @instances ||= []
      @instances << obj
    end

  end

  module InstanceMethods
    def add_instance(obj)
      self.class.add_instance(obj)
    end

    def pass_to_ancestor(obj)
      super_class = self.class.superclass
      super_class.add_instance(obj) if super_class != Object
    end
  end

end

class A
  include InstancesKeeper::InstanceMethods
  extend InstancesKeeper::ClassMethods

  def initialize
    add_instance(self)
    pass_to_ancestor(self)
  end
end

class B < A
  include InstancesKeeper::InstanceMethods
  extend InstancesKeeper::ClassMethods

  def initialize
    add_instance(self)
    pass_to_ancestor(self)
  end

end

def main
  a1 = A.new
  a2 = A.new
  puts 'A instances'
  puts '------------------'
  puts A.instances
  puts '------------------'
  b1 = B.new
  b2 = B.new
  puts 'A instances'
  puts A.instances
  puts 'B instances'
  puts '------------------'
  puts B.instances
  puts '------------------'
end

main
