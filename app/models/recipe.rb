class Recipe < ApplicationRecord
  attr_accessor :ingredients_attributes
  accepts_nested_attributes_for :ingredients
  validates :name, presence: true
  belongs_to :user
  has_many :ingredients
  has_one :menu

  scope :recent, -> { order(cooked: :asc) }

  def fetch(url)
    agent = Mechanize.new
    page = agent.get(url)
    title = page.search('.recipe-title')
    step = page.search('.step_text')
    ingredient_name = page.search('.ingredient_name')
    ingredient_quantity = page.search('.ingredient_quantity')

    steps_text = ''
    step.length.times do |i|
      steps_text << "#{i+1}.#{step[i].text.gsub!(/(\r\n|\r|\n)/, "")}\n"
    end
    
    self.name = title.text
    self.url = url
    self.cooking_recipe = steps_text

    @ingredients =  ingredient_name.length.times.map do |i| 
                      Ingredient.new( name: ingredient_name[i].text.gsub!(/(\r\n|\r|\n)/, ""), amount: ingredient_quantity[i].text.gsub!(/(\r\n|\r|\n)/, "") )
                    end
  end
end
