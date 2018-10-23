puts 'a ='
a = gets.chomp.to_f

puts 'b ='
b = gets.chomp.to_f

puts 'c ='
c = gets.chomp.to_f

array = [a,b,c].sort

if array[2]**2 == array[0]**2 + array[1]**2

  if array[0] + 1 == array[1]
    puts 'Rectangular and equilateral!'
  else
    puts 'Rectangular!'
  end

elsif array[0] == array[1] && array[1] != array[2]
  puts "Isosceles!"
elsif array[0] == array[1] && array[1] == array[2]
  puts "Equilateral!"
else
  puts "Just triangle!"
end
