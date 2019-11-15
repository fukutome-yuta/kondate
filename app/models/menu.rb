class Menu < ApplicationRecord
  before_validation :set_empty_url
  belongs_to :user
  belongs_to :recipe, optional: true
  scope :recent, -> { order(schedule: :asc) }

  def list_create(start_date, end_date)
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)

    result = {path:, message:}
    
    Menu.transaction do
      (start_date..end_date).each do |date|
        self.create!(schedule: date)
      end
    end
      result[:path] = menus_edit_url
      result[:message] = "献立表にメニューを追加してください。"
    rescue => e
      result[:path] = new_menu_url
      result[:message] = "献立表の作成に失敗しました。"
      raise ActiveRecord::Rollback
    ensure
      return result
  end

  private

  def set_empty_url
    self.url ||= ''
  end
end
