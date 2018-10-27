letters = ('a'..'z').to_a

nums = (1..letters.length).to_a

hash = {}

for i in 0..letters.length - 1 do
  hash [ letters[i].to_sym ] = nums[i]
end

hash.each { |k, v| puts "#{k} - #{v}" }
