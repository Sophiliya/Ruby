def perform(command, data = [])
  if block_given?
    yield(command, data)
  else p 'Please give me instructions.'
  end
end

strings = ['ruby python java scala oracle', 'math physics history']
numbers = [1,2,3,4,5]

perform('find words', strings) do |command, data|
  if command == 'find words'
    sizes = data.map { |s| s.split.size }
    index = sizes.index(sizes.max)
    p data[index]
  else
    result = {}
    data.each_with_index { |e, i| result[i + 1] = e }
    p result
  end
end

perform('parse numbers', numbers) do |command, data|
  if command == 'find words'
    sizes = data.map { |s| s.split.size }
    index = sizes.index(sizes.max)
    p data[index]
  else
    result = {}
    data.each_with_index { |e, i| result[i + 1] = e }
    p result
  end
end

perform('find words',strings)
