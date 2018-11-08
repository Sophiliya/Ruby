class Array
  def square
    self.map { |i| i * i }
  end

  def average
    is_string = self.map(&:class).include? (String)

    return 0 if is_string

    self.inject(:+).to_f / self.length
  end

  def even_odd
    ( self.select(&:even?).count - self.select(&:odd?).count ).abs
  end

  def reverse_strings
    is_string = self.map(&:class).uniq == [String]

    return 0 unless is_string

    self.map { |str| str.reverse }
  end

end

num = [1,2,3,4,5,7]
str = %w(apple banana carrot dragonfruit)
num_str = num + str

p num.square
p num.average
p str.average
p num.even_odd
p str.reverse_strings
p num.reverse_strings
p num_str.reverse_strings
