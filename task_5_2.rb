def maxmin(strings)
  lengths = strings.map(&:length)
  lengths.min + lengths.max
end

puts maxmin(["apple","kiwi","orange","mango","watermelon"]) 
