class FetchRecipe
  include ActiveModel::Model
  #attr_accessor :title, :url, :recipe, :names, :quantitys
  attr_accessor :title, :url, :recipe, :ingredients

  def initialize(url)
    agent = Mechanize.new
    @page = agent.get(url)
    @url = url
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
    @recipe = steps_text
    # @names = ingredient_name.length.times.map { |i| ingredient_name[i].text.strip }
    # @quantitys = ingredient_quantity.length.times.map { |i| ingredient_quantity[i].text.strip }
    @ingredients =  ingredient_name.length.times.map do |i| 
                      Recipe.ingredients.new( name: ingredient_name[i].text.strip, amount: ingredient_quantity[i].text.strip )
                    end
  end
end