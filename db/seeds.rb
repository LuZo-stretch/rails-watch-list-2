# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'
require 'json'

begin
api_url = 'http://tmdb.lewagon.com/movie/top_rated'
api_response = URI.open(api_url).read
parsed_data = JSON.parse(api_response)

parsed_data['results'].each do |movie_data|
  Movie.create!(
    title: movie_data['title'],
    overview: movie_data['overview'],
    rating: movie_data['vote_average'],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie_data["poster_path"]}"
  )
end
rescue => e
  puts "An error occurred: #{e.message}"
end
