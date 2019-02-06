require 'net/http'

class Query
  attr_reader :url 

  def initialize(url, headers = {})
    @url = url
    @headers = headers
  end

  def get
    uri = URI(@url)
    req = Net::HTTP::Get.new(uri)

    @headers.each { |header, value| req[header] = value }

    http         = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.instance_of?(URI::HTTPS)

    @res = http.request(req)
    @res
  end

  def last_response
    @res
  end

  def code_state
    @res.code
  end

  def response_body
    @res.body
  end

  def header
    @res.each_header { |header, value| puts "#{header}: #{value}"}
  end
end
