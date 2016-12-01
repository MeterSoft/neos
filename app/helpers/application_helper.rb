module ApplicationHelper
  ALERT_TYPES = [:error, :info, :success, :warning]

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      next if message.blank?

      type = :success if type == :notice
      type = :error   if type == :alert
      next unless ALERT_TYPES.include?(type)

      Array(message).each_with_index do |msg, i|
        text = content_tag(:div,
                           content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
                           msg.html_safe, :class => "alert fade in alert-#{type}", id: "autoremove_#{type}_#{i}"),
                           content_tag(:div, "<script type='text/javascript'> setTimeout(function () { $('#autoremove_#{type}_#{i}').alert('close')}, 5000) </script>".html_safe)
        flash_messages << text if message
      end
    end
    flash_messages.join("\n").html_safe
  end

  def purchases_count
    session[:purchases].uniq.size if session[:purchases]
  end
end
