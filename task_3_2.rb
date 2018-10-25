array = []

puts 'a ='
array << gets.chomp.to_f

puts 'b ='
array << gets.chomp.to_f

puts 'c ='
array << gets.chomp.to_f

array = array.sort!

f_rectangular = array[2]**2 == array[0]**2 + array[1]**2
f_isosceles = ( array[0] == array[1] && array[1] != array[2] ) || ( array[0] != array[1] && array[1] == array[2] )
f_equiteral = array[0] == array[1] && array[1] == array[2]

if f_rectangular && f_isosceles
  puts 'Rectangular and isosceles!'
  
elsif f_rectangular && !f_isosceles
    puts 'Rectangular!'
  
elsif !f_rectangular && f_isosceles
  puts 'Not rectangular but isosceles!'
  
elsif !f_rectangular && f_equiteral
  puts "Equilateral!"
  
else
  puts "Just triangle!"
end
