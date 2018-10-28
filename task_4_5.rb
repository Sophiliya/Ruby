puts 'Please enter day, month and year:'

day = gets.chomp.to_i
month = gets.chomp.to_i
year = gets.chomp.to_i

days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
f_leap_year = ( year % 4 == 0 && year % 100 != 0 ) || ( year % 400 == 0 )

sum_days = 0

if month == 1
  puts "#{year}-#{month}-#{day} = #{day}"
elsif f_leap_year && !( month ==2 && day < 29 )
  days_in_months[1] = 29
  sum_days = days_in_months[0..month-2].inject(0) { |sum, i| sum += i }
  puts "#{year}-#{month}-#{day} = #{sum_days + day}"
else
  sum_days = days_in_months[0..month-2].inject(0) { |sum, i| sum += i }
  puts "#{year}-#{month}-#{day} = #{sum_days + day}"
end
