class Factory

    def self.new(*args)

      class_name = args.shift if args[0].is_a? String

      begin
        args.map!(&:to_sym)
      rescue NoMethodError
        puts "Arguments must be a String or a Symbol"
        exit
      end

      klass = Class.new do

        attr_accessor *args

        define_method :initialize do |*values|
          args.each_with_index { |arg,i| instance_variable_set("@#{arg}",values[i]) }
        end

        yield if block_given?

        def == (other)
          result = true
          instance_variables.each { |var| result = false unless instance_variable_get(var) == other.instance_variable_get(var)}
          result
        end

        def [] (arg)
          instance_variable_get(to_instance_variable arg)
        end

        def []= (arg,value)
          instance_variable_set(to_instance_variable(arg), value)
        end

        private

        def to_instance_variable arg
          if arg.is_a? Integer
            sym = instance_variables[arg]
          else
            sym = arg[0] == "@" ? arg : "@#{arg}"
          end
          raise ArgumentError.new("Undefined offset #{arg} for Factory #{self.class}") if sym.nil?
          sym
        end
      end

      const_set(class_name, klass) unless class_name.nil?

      klass
    end

end
#
Cathe = Factory.new(:a,:b, "c") do
  public
  def lol
    puts "lol"
  end
end

a = Cathe.new(1,2,"c")
b = Cathe.new(1,2)
c = Cathe.new(1)

print "a[0]"; p a[0]
print "a[1]"; p a[1]
print "a[2]"; p a[2]
print "a[-1]"; p a[-1]
print "a[-2]"; p a[-2]
print "a[-3]"; p a[-3]
print "a['a']"; p a['a']
print "a['@a']"; p a['@a']
print "a[:a]"; p a[:a]
print "a[:@a]"; p a[:@a]

a[0] = "new value"
print 'set new value to a[0]= '; p a[0]
a[1] = "new value"
print 'set new value to a[1]= '; p a[1]
a[2] = "new value"
print 'set new value to a[2]= '; p a[2]
