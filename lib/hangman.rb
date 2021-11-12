# frozen_string_literal: false

require 'yaml'

# An instantion of the class Game will maintain the state of a game of hangman
class Game
  def initialize
    @board = ''
    @incorrect_guesses = []
    @incorrect_guesses_remaining = 5 # Head, torso, arm, arm, leg, leg (6th element means loss)
  end

  def play
    @secret_word = secret_word
    @secret_word.each_char { @board.concat('_') }
    while @incorrect_guesses_remaining.positive?
      puts "Incorrect guesses remaining: #{@incorrect_guesses_remaining}  |"\
        "  Incorrect guesses: #{@incorrect_guesses}"
      if play_round == 'game_saved'
        puts 'Game saved as game.yaml. Goodbye for now.'
        break
      end
      break if winner? == true
    end
    puts "You lose. The secret word was #{@secret_word}." if @incorrect_guesses_remaining.zero?
  end

  def winner?
    return unless @board == @secret_word

    puts "You win. The secret word was #{@secret_word}."
    true
  end

  def play_round
    saved = save_game?
    return 'game_saved' if saved == 'y'

    puts 'Enter guess'
    guess = gets.chomp.downcase
    if @secret_word.downcase.include?(guess)
      update_board(guess)
    else
      @incorrect_guesses.push(guess)
      @incorrect_guesses_remaining -= 1
    end
    puts @board
  end

  def save_game?
    puts 'Save game? y or n'
    desire = gets.chomp
    return unless desire == 'y'

    File.open('game.yaml', 'w') { |game| game.puts YAML.dump(self) }
    desire
  end

  def update_board(guess)
    @secret_word.split('').each_with_index do |v, i|
      @board[i] = guess if v == guess
    end
  end

  def secret_word
    contents = File.read('5desk.txt')
    word_arr = contents.split("\r\n")
    refined_word_arr = []
    word_arr.each do |word|
      refined_word_arr.push(word) if word.length >= 5 && word.length <= 12
    end
    refined_word_arr.sample
  end
end

def open_saved?
  puts 'Open saved game? y or n'
  return unless gets.chomp == 'y'

  File.open('game.yaml', 'r') { |game| YAML.load(game) }
end

def play
  saved_game = open_saved?
  if !saved_game.nil?
    saved_game.play
  else
    game = Game.new
    game.play
  end
end

play
