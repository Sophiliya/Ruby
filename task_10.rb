def perform(command, data = [])
  return if command == nil or data.empty?
  result = block_given? ? yield(command, data) : 'Please give me instructions.'
  p result 
end

strings = ['ruby python java scala oracle', 'math physics history']
numbers = [1,2,3,4,5]

perform('find words', strings) do |command, data|
  sizes = data.map { |s| s.split.size }
  data[sizes.index(sizes.max)]
end

perform('parse numbers', numbers) do |command, data|
  result = {}
  data.each.with_index(1) { |e, i| result[i] = e }
  result
end

perform('find words',strings)

perform(strings) 
