require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def included?(guess, grid)
  guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def score
    @grid = params[:letters]
    @score = params[:score]
      if included?(@score.upcase, @grid)
        if english_word?(@score)
        @output = "well done"
        else
        @output = "not an english word"
        end
      else
      @output = "not in the grid"
      end
  end

def english_word?(word)
  response = open("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.read)
  return json['found']
end

end
