require 'open-uri'
require 'json'


class GamesController < ApplicationController
  def new
    alphabet_array = ('a'..'z').to_a
    @rand_characters = []
    10.times { @rand_characters.push(alphabet_array.sample) }
  end

  def score
    @list = params[:list].gsub(/\W/, "").split("")
    @word = params[:word].split("")
    @return = ""
    @score = currentScore()

    def true_word(word)
      url = "https://wagon-dictionary.herokuapp.com/#{word}"
      user_serialized = open(url).read
      user = JSON.parse(user_serialized)
      user["found"]
    end

    if !(@word - @list).empty?
      @return = "The word can’t be built out of the original grid"
    elsif (@word - @list).empty? && !true_word(@word.join)
      @return = "The word is valid according to the grid, but is not a valid English word"
    elsif (@word - @list).empty? && true_word(@word.join)
      @return = "The word is valid according to the grid and is an English word"
      scoring(@word.join)
    end
  end

  def scoring(word)
    if session[:score].nil?
      session[:score] = 0
    end
    session[:score] = session[:score] + word.length
  end

  def currentScore
    session[:score]
  end
end
