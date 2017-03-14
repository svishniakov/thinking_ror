puts "Please enter A value:"
a = gets.chomp.to_f

puts "Please enter B value:"
b = gets.chomp.to_f

puts "Please enter C values"
c = gets.chomp.to_f

discriminant = b ** 2 - 4 * a * c
puts "Discriminant value: #{discriminant}"

if discriminant < 0
  puts "No equation roots"
elsif discriminant == 0
  puts "Root are equals with value: #{-b/2 * a}"
else
  D = Math.sqrt(discriminant)
  puts "Roots values: X1 = #{(-b + D)/2 * a}, X2 = #{(-b - D)/2 * a}"
end

