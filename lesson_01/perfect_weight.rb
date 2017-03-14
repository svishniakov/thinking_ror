puts "What is your name?"
name = gets.chomp

puts "How tall are you? (cm)"
height = gets.chomp.to_i

optimal_weight = height - 110

if optimal_weight > 0
  puts "You optimal weight should de: #{optimal_weight}"
else
  puts "You have an optimal weight"
end
