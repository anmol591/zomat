require 'net/http'
require 'json'
require 'pp'
class ItemsOrderController < ApplicationController
	
	def index
		
	end

	def display_categories 
	  @lat=params[:lat]
	  @lng=params[:long]
	  @location=params[:loc]
	  @cuisines_id=params[:cuisines][:id]
	  @city_id=params[:city_id]
	  @cat=getcategories_from_zomato
	end
	def display_cuisines
		@lat=params[:lat]
	  @lng=params[:long]
	  @location=params[:item][:location]
		city_details=getcitydetails_from_zomato(@lat,@lng)
		city_details[:location_suggestions].each do |f|
		     @city_id=f[:id]
		  end
	  @cuisines=getcuisines_from_zomato(@lat,@lng,@city_id)
	   
	end
	def search_restaurants
			@category_id=params[:category][:name]
			@lat=params[:lat]
			@lng=params[:long]
			@location=params[:loc]
			@city_id=params[:city_id]
			@cuisines_id=params[:cuisines][:id]
			@restaurants_list=get_restaurants_from_zomato(@lat,@lng,@city_id,@cuisines_id,@category_id)
	end
	def place_order
		
	end
	
	private
	def get_restaurants_from_zomato(lat,lng,city_id,cuisines_id,category_id)
			uri = URI.parse("https://developers.zomato.com/api/v2.1/search")
		 	http = Net::HTTP.new(uri.host, uri.port)
		  http.use_ssl = true
		  params = { :lat =>lat, :lon =>lng, :entity_id=>city_id, :entity_type=>'city', :radius=>3000, :cuisines=> cuisines_id.join(","), :sort=>'cost', :order=>'asc', :category=>category_id }
      uri.query = URI.encode_www_form(params)
		  request = Net::HTTP::Get.new(uri.request_uri)
		  request['user-key']="e9372470ff176505c8577c1c2d234f01"
		  res = http.request(request)
		  res=JSON.parse(res.body,symbolize_names: true)
	end
	def getcategories_from_zomato
		uri = URI.parse("https://developers.zomato.com/api/v2.1/categories")
	 	http = Net::HTTP.new(uri.host, uri.port)
	  	http.use_ssl = true
	  	request = Net::HTTP::Get.new(uri.request_uri)
	  	request['user-key']="e9372470ff176505c8577c1c2d234f01"
	  	res = http.request(request)
	  	res=JSON.parse(res.body,symbolize_names: true)
	end
	def getcitydetails_from_zomato(lat,lng)
		uri = URI.parse("https://developers.zomato.com/api/v2.1/cities")
	 	http = Net::HTTP.new(uri.host, uri.port)
	  	http.use_ssl = true
	  	params = { :lat =>lat, :lon =>lng }
        uri.query = URI.encode_www_form(params)
	  	request = Net::HTTP::Get.new(uri.request_uri)
	  	request['user-key']="e9372470ff176505c8577c1c2d234f01"
	  	res = http.request(request)
	  	res=JSON.parse(res.body,symbolize_names: true)

	end
	def getcuisines_from_zomato(lat,lng,city_id)
		uri = URI.parse("https://developers.zomato.com/api/v2.1/cuisines")
	 	http = Net::HTTP.new(uri.host, uri.port)
	  http.use_ssl = true
	  params = { :lat =>lat, :lon =>lng, :city_id=>city_id }
    uri.query = URI.encode_www_form(params)
	  request = Net::HTTP::Get.new(uri.request_uri)
	  request['user-key']="e9372470ff176505c8577c1c2d234f01"
	  res = http.request(request)
	  res=JSON.parse(res.body,symbolize_names: true)
	end

end
