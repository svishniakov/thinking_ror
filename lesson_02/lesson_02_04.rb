consonants = {}

('a'..'z').each_with_index do |key, index|
  consonants[key] = index - 1 if key.match(/[^aeiou]/)
end

puts consonants
