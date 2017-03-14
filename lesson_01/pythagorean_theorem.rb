puts "Please enter side one length:"
side_one = gets.chomp.to_f

puts "Please enter side two length:"
side_two = gets.chomp.to_f

puts "Please enter side three length"
side_three = gets.chomp.to_f

sides = [side_one, side_two, side_three]

side_max = sides.max
sides_min = sides.min(2)

if side_max ** 2 == sides_min[0] ** 2 + sides_min[1] ** 2
  puts "You have an equicrural"
  puts "and isoscales" if sides_min[0] == sides_min[1]
  puts "triangle"
else
  puts "Your trianle is no equicrural"
  puts "but equilateral" if sides.uniq.length == 1
  puts "but isoscales" if sides.uniq.length == 2
end
