# frozen_string_literal: false

contents = File.read('5desk.txt')
word_arr = contents.split("\r\n")
refined_word_arr = []
word_arr.each do |word|
  refined_word_arr.push(word) if word.length >= 5 && word.length <= 12
end

# An instantion of the class Game will maintain the state of a game of hangman
class Game
  attr_reader :secret_word
  attr_accessor :guesses, :board

  def initialize(guesses, words)
    @secret_word = words.sample
    @guesses = guesses
    @board = ''
  end

  def play
    @secret_word.each_char { @board.concat('_') }
    while @guesses.positive?
      puts "Guesses remaining: #{@guesses}"
      play_round
    end
    puts @secret_word
  end

  def play_round
    guess = gets.chomp
    if @secret_word.include?(guess)
      update_board(guess)
    else
      @guesses -= 1
    end
    puts @board
  end

  def update_board(guess)
    @secret_word.split('').each_with_index do |v, i|
      @board[i] = guess if v == guess
    end
  end
end

game = Game.new(4, refined_word_arr)
game.play
