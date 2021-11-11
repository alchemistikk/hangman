# frozen_string_literal: false

contents = File.read('5desk.txt')
word_arr = contents.split("\r\n")
refined_word_arr = []
word_arr.each do |word|
  refined_word_arr.push(word) if word.length >= 5 && word.length <= 12
end

class Game
  attr_reader :secret_word
  attr_accessor :guesses, :board
  
  def initialize(guesses, words)
    @secret_word = words.sample
    @guesses = guesses
    @board = ''
  end

  def play
    @secret_word.each_char do |letter|
      @board.concat(' _')
    end
    while @guesses.positive?
      puts "Guesses remaining: #{@guesses}"
      play_round
      @guesses -= 1
    end
  end

  def play_round
    guess = gets.chomp
    puts 'DOPE. YOU GOT IT.' if secret_word.include?(guess)
    puts board
  end  
end

# You should also display which correct letters have already been chosen
# (and their position in the word, e.g. _ r o g r a _ _ i n g) 
# and which incorrect letters have already been chosen.

game = Game.new(4, refined_word_arr)
game.play

