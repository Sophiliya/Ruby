puts 'Please enter day, month and year:'

day = gets.chomp.to_i
month = gets.chomp.to_i
year = gets.chomp.to_i

days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
f_leap_year = ( year % 4 == 0 && year % 100 != 0 ) || ( year % 400 == 0 )

sum_days = 0

for i in 0..month - 2 do
  if f_leap_year && i == 1
    sum_days += 29
  else
    sum_days += days_in_months[i]
  end
end

puts "#{year}-#{month}-#{day} = #{sum_days + day}"
