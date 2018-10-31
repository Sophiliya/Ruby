def maxmin(strings)
  length = []
  strings.each { |str| length << str.length }
  length.min + length.max
end

puts maxmin(["apple","kiwi","orange","mango","watermelon"])
