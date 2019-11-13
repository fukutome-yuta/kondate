class FetchRecipe
  include ActiveModel::Model
  attr_accessor :title, :url, :recipe, :ingredients

  def initialize(url)
    agent = Mechanize.new
    @page = agent.get(url)
  end
  
  def cookpad
    title = @page.search('.recipe-title')
    step = @page.search('.step_text')
    ingredient_name = @page.search('.ingredient_name')
    ingredient_quantity = @page.search('.ingredient_quantity')

    steps_text = ''
    step.length.times do |i|
      steps_text << "#{i+1}.#{step[i].text.strip}\n"
    end
    
    @title = title.text
    @url = url
    @recipe = steps_text

    @ingredients =  ingredient_name.length.times.map do |i| 
                      Ingredient.new( name: ingredient_name[i].text, amount: ingredient_quantity[i].text )
                    end
  end
end