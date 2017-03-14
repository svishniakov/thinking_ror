puts "What's your name?"
name = gets.chomp

puts "What the year you born?"
year = gets.chomp

puts "Hello #{name}! Your age is #{Time.new.year - year.to_i}!"
