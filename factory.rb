class Factory
  class << self

    def new(*args)

      class_name = args.shift if args[0].is_a? String

      get_symbols(args)

      klass = Class.new do

        args.each do |arg|
          attr_accessor arg
        end

        define_method :initialize do |*values|
          args.each_with_index do |arg,i|
            arg = "@"<<arg.to_s
            instance_variable_set(arg,values[i])
          end
        end

        yield if block_given?

        def == (other)
          result = true
          instance_variables.each { |var| result = false unless instance_variable_get(var) == other.instance_variable_get(var)}
          result
        end
      end

      const_set(class_name, klass) unless class_name.nil?

      klass
    end

    def get_symbols(args)
      args.map! do |arg|
        arg.to_sym if arg.respond_to? :to_sym
        raise ArgumentError('Argument must be a symbol or a String') unless arg.is_a? Symbol
        arg
      end
    end

  end
end

Cathe = Factory.new(:a,:b) do
  public
  def lol
    puts "lol"
  end
end

a = Cathe.new(1,2)
b = Cathe.new(1,2)
c = Cathe.new(1)

#
p a

p Cathe

p a == b
p a == c

