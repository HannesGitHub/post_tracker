module ApplicationHelper

  def error_class(error)
    if error.present?
      'has-error'
    end
  end

  def error_message(errors)
    if errors.present?
      display_errors = ""
      errors.each do |error|
        display_errors += "<label class='control-label'>#{error}</label>\n"
      end
      display_errors.html_safe
    end
  end

  def flash_error

  end
end
