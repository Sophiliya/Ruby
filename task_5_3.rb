goods = {}
price_cnt = {}

loop do
  puts 'Enter the product name:'
  product = gets.chomp.to_sym

  break if product.to_s == "stop"

  puts 'Enter the price:'
  price = gets.chomp.to_sym

  puts 'Enter the count:'
  cnt = gets.chomp.to_f

  goods[product] = { price => cnt }
end

p goods

sum = 0
total = 0

goods.each do |product, price_cnt|
  price_cnt.each { |price, cnt| sum = price.to_s.to_f * cnt }
  p "#{product} = #{sum}"
  total += sum
end

p "Total: #{total}."
