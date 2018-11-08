class Array
  def square
    result = []

    self.each { |i| result << i * i }

    result
  end

  def average
    f_string = self.inject(0) { |sum, i| i.class == String ? sum += 1 : sum = 0 } > 0

    return 0 if f_string

    avg = self.inject(0) { |sum, i| sum += i.to_f } / self.count
  end

  def even_odd
    ( self.select(&:even?).count - self.select(&:odd?).count ).abs
  end

  def reverse_strings
    result = []

    self.each { |str| result << str.reverse }

    result
  end

end

num = [1,2,3,4]
str = %w(apple banana carrot dragonfruit)

p num.square
p num.average
p str.average
p num.even_odd
p str.reverse_strings
