sides = []

puts 'a ='
sides << gets.chomp.to_f

puts 'b ='
sides << gets.chomp.to_f

puts 'c ='
sides << gets.chomp.to_f

sides = sides.sort!

hypotenuse = sides[2]
second_side = sides[1]
first_side = sides[0]

f_rectangular = hypotenuse ** 2 == first_side ** 2 + second_side ** 2
f_isosceles = ( first_side == second_side && second_side != hypotenuse ) || ( first_side != second_side && second_side == hypotenuse )
f_equilateral = first_side == second_side && second_side == hypotenuse

if f_rectangular && f_isosceles
  puts 'Rectangular and isosceles!'
elsif f_rectangular && !f_isosceles
    puts 'Rectangular!'
elsif !f_rectangular && f_isosceles
  puts 'Not rectangular but isosceles!'
elsif f_equilateral
  puts "Equilateral!"
else
  puts "Just triangle!"
end
