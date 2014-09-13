module ServersHelper
  def panel_icon(type)
    case type.to_i
      when 3
        return '<em class="fa fa-gear fa-fw"></em>'.html_safe # process
      when 5
        return '<em class="fa fa-hdd-o fa-fw"></em>'.html_safe # system
      else
        return '<em class="fa fa-hdd-o fa-fw"></em>'.html_safe
    end
  end

  def panel_color(status)
    if status.to_i == 0
      return 'success'
    else
      return 'danger'
    end
  end

  def panel_content(event)
    case event.type.to_i
      when 3
        return [event.memory, event.cpu]
      when 5
        return event.system
      else

    end
  end
end
