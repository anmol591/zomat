  require 'pry'
require 'net/http'
require 'json'

    uri = URI.parse("http://www.trodly.com/")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = false 
    request = Net::HTTP::Get.new(uri.request_uri) #using get method
    result = http.request(request) #send an http request
    result = result.body 
    result = result.gsub(/\n/, '')
    result = result.gsub(/\r/, '')
    result = result.gsub(/\t/, '')
    matches = result.scan(/<span class="price-info" >.*?<.*?>.*?>.*?;.(\d+)</) 
    matches.each do |val| #iterate an array
      puts val
    end

      