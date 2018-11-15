  $items = [{:name=>"Snickers", :code=>"A01", :quantity=>10, :price=>250},
           {:name=>"Pepsi", :code=>"A02", :quantity=>5, :price=>350},
           {:name=>"Orange Juice", :code=>"A03", :quantity=>2, :price=>400},
           {:name=>"Bon Aqua", :code=>"A04", :quantity=>7, :price=>120},
           {:name=>"Bounty", :code=>"A05", :quantity=>10, :price=>270}]

def vend(code, sum)
  item_chosen = $items.find { |item| item[:code] == code  }

  name = item_chosen[:name]
  price = item_chosen[:price]

  return p "#{name}: ended." if item_chosen[:quantity] == 0

  if sum == price
    p item_chosen[:name]
    item_chosen[:quantity] -= 1
  elsif sum > price
    p "#{name}, change is #{sum - price}."
    item_chosen[:quantity] -= 1
  else
    p "Please add more #{price - sum} for #{name}."
  end

  p $items

end

vend('A03',400)
vend('A04',200)
vend('A03',400)
vend('A05',200)
vend('A03',300)
