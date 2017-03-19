consonants = {}

('a'..'z').each.with_index(-1) do |key, index|
  consonants[key] = index if key.match(/[^aeiou]/)
end

puts consonants
