require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)



    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================



    base_url= "http://maps.googleapis.com/maps/api/geocode/json?address="
    full_url=base_url+url_safe_street_address


 parsed_data= JSON.parse(open(full_url).read)

 @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

 @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]


    base_url="https://api.forecast.io/forecast/c3dc222c33812ab534d5f3c93ef6b0b2/"
    full_url=base_url.to_s+@latitude.to_s+","+@longitude.to_s

    parsed_data = JSON.parse(open(full_url).read)




    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["hourly"]["data"][0]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days =  parsed_data["daily"]["summary"]





    render("street_to_weather.html.erb")
  end
end
