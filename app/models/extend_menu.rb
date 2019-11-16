class ExtendMenu
  include ActiveModel::Model

  def list_create(user, start_date, end_date)
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)

    result = {}
    
    Menu.transaction do
      (start_date..end_date).each do |date|
        menu = user.menus.new(schedule: date)
        menu.save!
      end
    end   
      result[:path] = '/menus/edit'
      result[:message] = "献立表にメニューを追加してください。"
    rescue => e
      result[:path] = '/menus/new'
      result[:message] = "献立表の作成に失敗しました。"
      raise ActiveRecord::Rollback
    ensure
      return result
  end

  def list_update(user, before_id, after_id)
    before = user.menus.find(before_id)
    after = user.recipes.find(after_id)
    message = before.name.present? ? "#{before.schedule}のメニューを変更しました。" : "献立表に「#{after.name}」を追加しました。"
    before.update!(recipe_id: after.id, name: after.name, url: after.url)
    return message
  end

end