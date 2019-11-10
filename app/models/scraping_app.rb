require 'mechanize'

agent = Mechanize.new
page = agent.get('https://cookpad.com/recipe/4874529')
title = page.search('.recipe-title')
name = page.search('.ingredient_name')
quantity = page.search('.ingredient_quantity')
step = page.search('.step_text')
ingredients = []
i = 0
puts title.text
name.each do |n|
  ingredient = { name: n.text, quantity: quantity[i].text }
  ingredients << ingredient
  i = i + 1
end

ingredients.each do |ing|
  puts "#{ing[:name]}：#{ing[:quantity]}"
end

i = 1
step.each do |s|
  puts "#{i}.#{s.text}"
  i = i + 1
end