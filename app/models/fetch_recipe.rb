class FetchRecipe
  include ActiveModel::Model
  attr_accessor :title, :how_many, :url, :recipe, :names, :quantitys

  def initialize(url)
    agent = Mechanize.new
    @page = agent.get(url)
    @url = url
  end
  
  def cookpad
    title = @page.search('.recipe-title')
    how_many = @page.search('span.servings_for.yield')
    step = @page.search('.step_text')
    ingredient_name = @page.search('.ingredient_name')
    ingredient_quantity = @page.search('.ingredient_quantity')
    
    steps_text = ''
    step.length.times do |i|
      steps_text << "#{i+1}.#{step[i].text.strip}\n"
    end

    @title = title.text
    @how_many = how_many.nil? ? '' : how_many.text
    @recipe = steps_text
    @names = ingredient_name.length.times.map { |i| ingredient_name[i].text.strip }
    @quantitys = ingredient_quantity.length.times.map { |i| ingredient_quantity[i].text.strip }
  end
end