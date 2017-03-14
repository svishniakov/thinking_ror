puts "What is your name?"
name = gets.chomp

puts "How tall are you? (cm)"
height = gets.chomp

optimal_weight = height.to_i - 110

if optimal_weight > 0
  puts "You optimal weight should de: #{optimal_weight}"
elsif optimal_weight <= 0
  puts "You have an optimal weight"
end
