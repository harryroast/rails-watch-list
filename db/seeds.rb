# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "json"
require "open-uri"

url = 'https://tmdb.lewagon.com/movie/top_rated'
user_serialized = URI.open(url).read
user = JSON.parse(user_serialized)
films = user["results"]
first_film = films[1]

picture_url = "https://image.tmdb.org/t/p/original"

films.each do |film|
  film_data = {
    title: film["title"],
    overview: film["overview"],
    poster_url: "#{picture_url}#{film["poster_path"]}",
    rating: film["vote_average"].round(1)
  }
  Movie.create(film_data)
  puts "#{film['title']} has been added"
end
