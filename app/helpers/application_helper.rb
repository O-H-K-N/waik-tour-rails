module ApplicationHelper
  # タブタイトル
  def page_title(page_title = '', admin = false)
    base_title = t('defaults.app_title')
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  # 表示中のコントローラーを
  def active_if(path)
    path == controller_path ? 'active' : ''
  end
end