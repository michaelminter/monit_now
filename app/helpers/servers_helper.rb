module ServersHelper
  def panel_icon(type)
    case type
      when 3
        return '<em class="fa fa-gear fa-fw"></em>'.html_safe
      when 5
        return '<em class="fa fa-hdd-o fa-fw"></em>'.html_safe
      else
        return '<em class="fa fa-hdd-o fa-fw"></em>'.html_safe
    end
  end

  def panel_color(type)
    if type.to_i == 0
      return 'success'
    else
      return 'danger'
    end
  end
end
