require './factory.rb'

Test = Factory.new(:a,:b, "c") do
  public
  def test_method_from_block
    puts "test_method_from_block"
  end
end

puts "\nInstances: "
a = Test.new(1,2,'c value')
b = Test.new(1,2)
c = Test.new(1,2)
puts "a = #{a.inspect}"
puts "b = #{b.inspect}"
puts "c = #{c.inspect}"

puts "\nCompramissions:"
puts "a == b - #{a==b}"
puts "b == c - #{b==c}"

puts "\nArguments use:"
puts "a[0]= #{a[0]}"
puts "a[1]= #{a[1]}"
puts "a[2]= #{a[2]}"
puts "a[-1]= "
puts "a[-2]= "
puts "a[-3]= "
puts "a['a']= "
puts "a['@a']= "
puts "a[:a]= "
puts "a[:@a]= "

puts "\nArguments set:"
a[0] = "new value"
puts 'set new value to a[0]= '; p a[0]
a[1] = "new value"
puts 'set new value to a[1]= '; p a[1]
a[2] = "new value"
puts 'set new value to a[2]= '; p a[2]