letters = ('a'..'z').to_a

nums = (1..letters.length).to_a

vowels = ['a','e','i','o','u']

hash = {}

for i in 0..letters.length - 1 do
  if vowels.include? ( letters[i] )
    hash [ letters[i].to_sym ] = nums[i]
  end
end

hash.each { |k, v| puts "#{k} - #{v}" }
