total_amount = 0

basket = {}

loop do
  puts "Please enter product name or \"stop\" when you finished to enter products"
  product = gets.chomp
  break if product == "stop"

  puts "Please enter product price"
  price = gets.chomp.to_f

  puts "Please enter quantity"
  qty = gets.chomp.to_f

  basket[product] = { :price => price, :quantity => qty, :amount => price * qty }
  total_amount += basket[product][:amount]
end

basket.each do |basket_line_name, basket_line_details|
  puts "*" * 40
  puts "Product name: #{basket_line_name}"
  puts "-" * 40
  puts "Price: #{basket_line_details[:price]}, Quantity: #{basket_line_details[:quantity]}, Amount: #{basket_line_details[:amount]}"
end

puts "*" * 40
puts "Total amount: #{total_amount}"
