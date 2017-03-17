fibonacci_arr = []

def fibonacci(number)
    if number < 3
        1
    else
        fibonacci(number - 1) + fibonacci(number - 2)
    end
end

(1..16).each {|number| fibonacci_arr << fibonacci(number) if fibonacci(number) <= 100 }
puts fibonacci_arr
