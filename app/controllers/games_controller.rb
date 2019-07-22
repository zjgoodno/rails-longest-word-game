require "open-uri"
require 'json'

class GamesController < ApplicationController

#Action
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def checkEnglish
    response = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
    json = JSON.parse(response)
    return json["found"]
  end

  def checkInGrid
    attempt = params[:word].upcase.split(//)
    return attempt.all? { |letter| attempt.count(letter) <= params[:letters].count(letter) }
  end


#Action
  def score
    if checkEnglish && checkInGrid
      @response = "Congratulations! #{params[:word]}"
    elsif !checkInGrid
      @response = "Sorry but #{params[:word]} cannot be built out of #{params[:letters]}"
    elsif !checkEnglish
      @response = "Sorry but #{params[:word]} is not an English word"
    end
  end
end
