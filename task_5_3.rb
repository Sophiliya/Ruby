goods = {}
price_count = {}

loop do
  puts 'Enter the product name:'
  product = gets.chomp.downcase.to_sym

  break if product.to_s == "stop"

  puts 'Enter the price:'
  price = gets.chomp.to_f

  puts 'Enter the count:'
  count = gets.chomp.to_f

  goods[product] = { price: price, amount: count }
end

p goods

sum = 0
total = 0

goods.each do |product, price_count|
  sum = price_count[:price] * price_count[:amount]
  total += sum
  p "#{product} = #{sum}"
end

p "Total: #{total}."
