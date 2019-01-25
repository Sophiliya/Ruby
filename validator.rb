module Validator
  def valid?(name)
    name.empty? ? raise : true
  rescue
    message = "!!! Exception (#{Time.now}): argument must not be empty."
    puts message
    write_log(message)
    false
  end

  def number_valid?(arg)
    numbers = (0..9).to_a.map(&:to_s)
    arg.each_char.map { |c| numbers.include?(c) }.count == arg.length ? true : raise
  rescue
    message = "!!! Exception (#{Time.now}): argument must be numeric."
    puts message
    write_log(message)
    false
  end

  def index_exists?(index, array_length)
    (1..array_length).to_a.include?(index) ? true : raise
  rescue
    message = "!!! Exception (#{Time.now}): enter the correct index."
    puts message
    write_log(message)
    false
  end

  def exists?(object_array, object_name)
    object_array.empty? ? raise : true
  rescue
    message = "!!! Exception (#{Time.now}): #{object_name.capitalize}: there is no such object."
    puts message
    write_log(message)
    false
  end

  def write_log(data)
    File.open('errors.log', 'a') do |f|
      f.puts data
    end
  end
end
