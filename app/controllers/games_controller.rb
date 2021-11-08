require 'json'
require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    result_serialized = URI.open(url).read
    result = JSON.parse(result_serialized)
    # check if result.found == true
    if result['found'] == true
      @is_english_word = true
    else
      grid = @letters.split("")
      @is_english_word = false
    end
    if params[:word].chars.all? { |char| params[:word].count(char) <= grid.count(char) }
      @words_are_included = true
    else
      @words_are_included = false
    end
  end
end
# letters are included in grid
# The word can’t be built out of the original grid
# if !@letters.include? params[:word].chars
#   @words_are_included = false
# # The word is valid according to the grid, but is not a valid English word
# elsif @words_are_included=true && @is_english_word = false
# # The word is valid according to the grid and is an English word
# elsif @words_are_included = true && @is_english_word = true
