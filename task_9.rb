  $items = [{:name=>"Snickers", :code=>"A01", :quantity=>10, :price=>250},
           {:name=>"Pepsi", :code=>"A02", :quantity=>5, :price=>350},
           {:name=>"Orange Juice", :code=>"A03", :quantity=>2, :price=>400},
           {:name=>"Bon Aqua", :code=>"A04", :quantity=>7, :price=>120},
           {:name=>"Bounty", :code=>"A05", :quantity=>10, :price=>270}]

def vend(code, sum)
  item_chosen = $items.find { |item| item[:code] == code  }

  if item_chosen[:quantity] == 0
    p "#{item_chosen[:name]}: ended."
    p $items
  elsif sum == item_chosen[:price]
    p item_chosen[:name]
    item_chosen[:quantity] -= 1
    p $items
  elsif sum > item_chosen[:price]
    p "#{item_chosen[:name]}, change is #{sum - item_chosen[:price]}."
    item_chosen[:quantity] -= 1
    p $items
  elsif sum < item_chosen[:price]
    p "Please add more #{item_chosen[:price] - sum} for #{item_chosen[:name]}."
    p $items
  end

end

vend('A03',400)
vend('A04',200)
vend('A03',400)
vend('A05',200)
vend('A03',300)
