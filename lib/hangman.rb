# frozen_string_literal: false

# An instantion of the class Game will maintain the state of a game of hangman
class Game
  def initialize
    @incorrect_guesses_remaining = 5 # Head, torso, arm, arm, leg, leg (6th element means loss)
    @board = ''
    @incorrect_guesses = []
  end

  def play
    @secret_word = secret_word
    @secret_word.each_char { @board.concat('_') }
    while @incorrect_guesses_remaining.positive?
      puts "Incorrect guesses remaining: #{@incorrect_guesses_remaining}  |"\
        "  Incorrect guesses: #{@incorrect_guesses}"
      play_round
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
    # Add option to save the game
    guess = gets.chomp.downcase
    if @secret_word.downcase.include?(guess)
      update_board(guess)
    else
      @incorrect_guesses.push(guess)
      @incorrect_guesses_remaining -= 1
    end
    puts @board
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

game = Game.new
game.play
