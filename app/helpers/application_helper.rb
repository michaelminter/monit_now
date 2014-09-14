module ApplicationHelper
  def total_data_usage(bytes)
    case bytes.to_i
      when 1000000000
        return "#{(bytes.to_i / 1000000000).round(3)} GB"
      when 1000000..999999999
        return "#{(bytes.to_i / 1000000).round(3)} MB"
      when 1000..999999
        return "#{(bytes.to_i / 1000).round(3)} KB"
      when 0..999
        return "#{bytes} B"
    end
  end
end
