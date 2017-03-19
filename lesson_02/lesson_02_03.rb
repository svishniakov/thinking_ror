fibonacci_sequence = [1, 1]

while (sequence_number = fibonacci_sequence[-1] + fibonacci_sequence[-2]) < 100
  fibonacci_sequence << sequence_number
end

puts fibonacci_sequence
