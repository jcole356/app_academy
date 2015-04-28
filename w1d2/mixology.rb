def remix(ingredients)
  results = []
  alcohols = []
  mixers = []
  ingredients.each do |pair|
    alcohols << pair[0]
    mixers   << pair[1]
  end

  mixers.shuffle!

  alcohols.each_with_index do |alcohol, i|
    results << [alcohols[i], mixers[i]]
  end

  results
end

p remix([
        ["rum", "coke"],
        ["gin", "tonic"],
        ["scotch", "soda"]
        ])
