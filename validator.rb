module Validator
  def valid?(name)
    name.empty? ? raise : true
  rescue
    puts "!!! Exception: argument must not be empty."
  end

  def number_valid?(arg)
    return unless valid?(arg)
    numbers = (0..9).to_a.map(&:to_s)
    arg.each_char.find { |c| numbers.include?(c) == false } ? raise : true
  rescue
    puts "!!! Exception: argument must be numeric."
  end

  def index_exists?(index, array_length)
    (1..array_length).to_a.include?(index) ? true : raise
  rescue
    puts '!!! Exception: enter the correct index.'
  end

  def exists?(object_array, object_name)
    object_array.empty? ? raise : true
  rescue
    puts "!!! Exception: #{object_name.capitalize}: there is no such object."
  end

  def is_enough?(object_array, number, object_name)
    object_array.count >= number ? true : raise
  rescue
    puts "!!! Exception: number of #{object_name} is not enough."
  end
end
