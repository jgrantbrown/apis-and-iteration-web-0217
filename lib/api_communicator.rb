require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  films_hash = {}
  movie_array = []
  character_url_arr = []
  character_hash["results"].each do |info|
    if info["name"].downcase == character
      character_url_arr = info["films"]
    end
  end
    character_url_arr.each do |url|
      url_to_movie_raw= RestClient.get(url)
      url_to_movie= JSON.parse(url_to_movie_raw)
      movie_array<<url_to_movie
    end
    films_hash[character] = movie_array

  #url_to_movie_raw = RestClient.get('http://swapi.co/api/films/6/')
  #url_to_movie = JSON.parse(url_to_movie_raw)
films_hash



  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_hash)
  movie_title = []
  films_hash.each do |name, filmarr|
    filmarr.each do |film|
      movie_title << film["title"]
    end

  end
  movie_title.each_with_index do |name, i|
    puts "#{(i + 1)}. #{name}"
  end
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
