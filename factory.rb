class Factory
  class << self

    def new(*args)

      class_name = args.shift if args[0].is_a? String

      get_symbols(args)

      klass = Class.new do
        define_method :initialize do |*values|
          args.each_with_index do |arg,i|
            instance_variable_set(arg,values[i])
          end
        end

        yield if block_given?
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

Cathe = Factory.new(:@a,:@b) do
  public
  def lol
    puts "lol"
  end
end

a = Cathe.new(1,2)
#
p a

p Cathe

Cathe.lol
