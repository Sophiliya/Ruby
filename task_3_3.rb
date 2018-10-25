puts 'Please eneter 3 coefficients:'
a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f

d = b ** 2 - (4 * a * c)
puts 'Results:'
puts "D = #{d}"

d_sqrt = Math.sqrt(d)

if d > 0
  x1 = ( -b + d_sqrt ) / ( 2 * a )
  x2 = ( -b - d_sqrt ) / ( 2 * a )
  puts "x1 = #{x1} and x2 = #{x2}."
elsif d == 0
  x = -b / ( 2 * a )
  puts "x = #{x}."
else
  puts "The equation has no valid roots!"
end
