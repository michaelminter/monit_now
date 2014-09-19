module ServersHelper
  def panel_color(current_service)
    if current_service.created_at < 30.minutes.ago
      return 'default'
    else
      if current_service.status.to_i == 0
        return 'success'
      else
        return 'danger'
      end
    end
  end

  def bar_color(current_service)
    current_service.created_at > 30.minutes.ago ? '#5BAB41' : '#6E6E6E'
  end

  def call_service(portlet)
    return '' if portlet.services.count == 0
    case portlet.type.to_i
      when 0
        # https://mmonit.com/monit/documentation/#filesystem_flags_testing
        render :partial => 'shared/panels/filesystem', locals: { portlet: portlet }
      when 1
        render :partial => 'shared/panels/directory', locals: { portlet: portlet }
      when 2
        render :partial => 'shared/panels/file', locals: { portlet: portlet }
      when 3
        render :partial => 'shared/panels/process', locals: { portlet: portlet }
      when 4
        render :partial => 'shared/panels/host', locals: { portlet: portlet }
      when 5
        render :partial => 'shared/panels/system', locals: { portlet: portlet }
      when 7
        render :partial => 'shared/panels/program', locals: { portlet: portlet }
      else
        # err
  end
end

  def type_label(key, value)
    # service types
    type = {}
    type[0] = 'FILESYSTEM' #
    type[1] = 'DIRECTORY' #
    type[2] = 'FILE' #
    type[3] = 'PROCESS' #
    type[4] = 'HOST' #
    type[5] = 'SYSTEM' #
    type[6] = 'FIFO'
    type[7] = 'PROGRAM' #

    monitor = {}
    monitor[0] = 'NOT'
    monitor[1] = 'YES'
    monitor[2] = 'INIT'
    monitor[4] = 'WAITING'

    every = {}
    every[0] = 'CYCLE'
    every[1] = 'SKIPCYCLES'
    every[2] = 'CRON'
    every[3] = 'NOTINCRON'

    state = {}
    state[0] = 'SUCCEEDED'
    state[1] = 'FAILED'
    state[2] = 'CHANGED'
    state[3] = 'CHANGEDNOT'
    state[4] = 'INIT'

    action = {}
    action[0] = 'IGNORE'
    action[1] = 'ALERT'
    action[2] = 'RESTART'
    action[3] = 'STOP'
    action[4] = 'EXEC'
    action[5] = 'UNMONITOR'
    action[6] = 'START'
    action[7] = 'MONITOR'

    case key
      when 'type'
        return type[value.to_i] rescue ''
      when 'monitor'
        return monitor[value.to_i] rescue ''
      else
        return value
    end
  end
end
