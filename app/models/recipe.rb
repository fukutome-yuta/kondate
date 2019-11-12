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

    steps_text = ''
    step.length.times do |i|
      steps_text << "#{i+1}.#{step(i).text.gsub!(/(\r\n|\r|\n)/, "")}\n"
    end

    # i = 1
    # step.each do |s|
    #   steps_text << "#{i}.#{s.text.gsub!(/(\r\n|\r|\n)/, "")}\n"
    #   i = i + 1
    # end
    
    self.name = title.text
    self.url = url
    self.cooking_recipe = steps_text
  end
end
