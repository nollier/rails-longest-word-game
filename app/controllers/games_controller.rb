require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    letter = ('A'..'Z').to_a
    @letters = []
    9.times do
      @letters << letter.sample
    end
    @letters
  end

  def score
    @word = params[:word].downcase
    @letters = params[:letters]

    if valid_word?(@word, @letters) == true && word_exist?(@word) == true
      @score = 'The word is valid according to the grid and is an English word'
    elsif valid_word?(@word, @letters) == true
      @score = 'The word is valid according to the grid, but is not a valid English word'
    else
      @score = 'The word can’t be built out of the original grid'
    end
  end

  def word_exist?(word)
    json = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    hash_word = JSON.parse(json)
    if hash_word['found'] == true
      return true
    else
      return false
    end
  end

  def valid_word?(word, letters)
    word.upcase.chars.all? { |letter| word.upcase.count(letter) <= letters.count(letter) }
  end
end
