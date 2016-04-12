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
