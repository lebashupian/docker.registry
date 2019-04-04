#!/usr/bin/env ruby
# coding: utf-8

require 'net/http'
require 'json'

url = URI.parse('https://cangku.io/v2/_catalog')
http = Net::HTTP.new(url.host, url.port)
#p http.methods
http.use_ssl = true if url.scheme == 'https'
http.ca_file="/home/ruby/docker.op/cangku.io.crt"

req=Net::HTTP::Get.new(url.path)
#p req.methods
req.basic_auth "foo","foo123"
hash=JSON.parse http.request(req).body
hash["repositories"].each {|x|
	req=Net::HTTP::Get.new("/v2/#{x}/tags/list")
	req.basic_auth "foo","foo123"
	hash2=JSON.parse http.request(req).body
	hash2["tags"].each {|x2|
		puts "#{x}  #{x2}"
	}	
}

#request = Net::HTTP.post_form   url,{ "username" => "foo" , "password" => "foo123"}
#puts http.request(request).body