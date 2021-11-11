# frozen_string_literal: true

contents = File.read('5desk.txt')
word_arr = contents.split("\r\n")
refined_word_arr = []
word_arr.each do |word|
  refined_word_arr.push(word) if word.length >= 5 && word.length <= 12
end

def play_game(guesses, words)
  secret_word = words.sample
  guesses_remaining = guesses
  play_round(secret_word, guesses_remaining)
end

def play_round(secret_word, guesses_remaining)
  guess = gets.chomp
  puts "DOPE. YOU GOT IT." if secret_word.include?(guess)
  guesses_remaining -= 1
end

play_game(4, refined_word_arr)
