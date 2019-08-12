require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @userword = params[:userword]
    @letters = params[:letters]
    if in_the_grid(@userword, @letters) == false
      @score = 'notinthegrid'
    elsif !english_word(@userword)
      @score = 'notenglish'
    else
      @score = 'great'
    end
  end

  private

  def english_word(attempt)
    get_answer = open("https://wagon-dictionary.herokuapp.com/#{attempt}").read
    JSON.parse(get_answer)['found']
  end

  def in_the_grid(user, computer)
    # user.upcase.chars
    (0...user.length).to_a.each do |i|
      return false unless computer.include?(user[i].upcase)
    end
    return true
  end
end
