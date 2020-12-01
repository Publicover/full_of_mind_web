# frozen_string_literal: true

module ApplicationHelper
  def active_if(view_path)
    'active' if current_page?(view_path)
  end
end
