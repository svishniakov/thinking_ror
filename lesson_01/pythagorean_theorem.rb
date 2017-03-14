puts "Please enter side one length:"
side_one = gets.chomp

puts "Please enter side two length:"
side_two = gets.chomp

puts "Please enter side three length"
side_three = gets.chomp

sides = [side_one.to_f, side_two.to_f, side_three.to_f]

sides_max = sides.max
sides_min = sides.min(2)

if sides_max ** 2 == sides_min[0] ** 2 + sides_min[1] ** 2
  puts "You have an equicrural"
  puts "and isoscales" if sides_min[0] == sides_min[1]
  puts "triangle"
else
  puts "Your trianle is no equicrural"
  puts "but equilateral" if sides.uniq.length == 1
  puts "but isoscales" if sides.uniq.length == 2
end
