puts "Please enter year"
year = gets.chomp.to_i
puts "Please enter month"
month = gets.chomp.to_i
puts "Please enter day"
day = gets.chomp.to_i

year_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
year_days[1] = 29 if year % 4 == 0 && year % 100 != 0 || year % 400 == 0

if month <= 12
  year_days.pop(12 - month + 1)
  day_number = (year_days.inject{ |sum,x| sum + x }).to_i + day
else
  puts "Wrong month entered"
  exit
end

puts "Day number: #{day_number}"
