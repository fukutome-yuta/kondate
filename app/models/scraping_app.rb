require 'mechanize'

agent = Mechanize.new
page = agent.get('https://cookpad.com/recipe/4874529')
title = page.search('.recipe-title')
name = page.search('.ingredient_name')
quantity = page.search('.ingredient_quantity')
step = page.search('.step_text')
ingredients = []

puts title.text

ingredients = name.length.times.map { |i| { name: name[i].text.gsub!(/(\r\n|\r|\n)/, ""), quantity: quantity[i].text.gsub!(/(\r\n|\r|\n)/, "") } }

puts ingredients

ingredients.each do |ing|
  puts "#{ing[:name]}：#{ing[:quantity]}"
end

steps_text = ''
step.length.times do |i|
  steps_text << "#{i+1}.#{step[i].text.gsub!(/(\r\n|\r|\n)/, "")}\n"
end

puts steps_text