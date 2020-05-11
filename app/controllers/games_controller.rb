class GamesController < ApplicationController
  def new
    letter = ('A'..'Z').to_a
    @letters = []
    9.times do
      @letters << letter.sample
    end
    @letters
  end
end
