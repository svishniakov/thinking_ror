total_amount = 0

products = {}

loop do
  puts "Please enter product name or \"stop\" when you finished to enter products"
  product = gets.chomp
  break if product == "stop"

  puts "Please enter product price"
  price = gets.chomp.to_f

  puts "Please enter quantity"
  qty = gets.chomp.to_f

  products[product] = { "Price" => price, "Quantity" => qty, "Amount" => price * qty }
  total_amount += products[product]["Amount"]
end

products.each do |key, value|
  puts "*" * 20
  puts key
  puts "-" * 20
  value.each do |key, value|
    puts "#{key} - #{value}"
  end
end

puts "*" * 20
puts "Total amount: #{total_amount}"
