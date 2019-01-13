module Validator
  def valid?(name)
    if name.empty?
      raise ArgumentError.new('name must not be empty.')
    else
      true
    end
  end

  def number_valid?(arg)
    valid?(arg)
    numbers = (0..9).to_a.map(&:to_s)
    if arg.each_char.find { |c| numbers.include?(c) == false }
      raise TypeError.new('argument must be numeric.')
    else
      true
    end
  end

  def index_exists?(index, array_length)
    (1..array_length).to_a.include?(index) ? true : raise
  rescue => e
    puts '!!! Exception: enter the correct index.'
  end

  def exists?(object)
    if object.empty?
      raise RuntimeError.new('There is no such object.')
    else
      true
    end
  end
end
