def find_max_min(string)
  numbers = []
  string.split.each { |i| numbers << string[i].to_f }
  [numbers.max, numbers.min]
end

p find_max_min("12 34 -09 78 56 456 -797")
