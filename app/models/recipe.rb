class Recipe < ApplicationRecord
  validates :name, presence: true
  has_many :incredients
  belongs_to :user
  has_one :menu

  scope :recent, -> { order(cooked: :asc) }

  def fetch(url)
    agent = Mechanize.new
    page = agent.get(url)
    title = page.search('.recipe-title')
    step = page.search('.step_text')

    i = 1
    steps_text = ''
    
    step.each do |s|
      steps_text << "#{i}.#{s.text}\n"
      i = i + 1
    end
    
    self.name = title.text
    self.url = url
    self.cooking_recipe = steps_text
  end
end
