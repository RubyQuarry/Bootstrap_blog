module ApplicationHelper


  def date_format(obj)
    day = obj.created_at.day.ordinalize
    obj.created_at.strftime("%A, %B #{day} %Y") # => "{ Name of day , Month , day , year }"
  end

  def month_year_convertor(arr)
    "#{Date::MONTHNAMES[arr[0]]} #{arr[1]}"
  end


   class CodeRayify < Redcarpet::Render::HTML
      def block_code(code, language)
        language ||= 'markdown'
        CodeRay.scan(code, language).div(:line_numbers => :table)
      end
    end

    def markdown(text)
      coderayified = CodeRayify.new(:filter_html => true,
                                    :hard_wrap => true)
      options = {
        :fenced_code_blocks => true,
        :no_intra_emphasis => true,
        :autolink => true,
        :strikethrough => true,
        :lax_html_blocks => true,
        :superscript => true,
        :tables => true,
        :highlight => true
      }
      markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
      markdown_to_html.render(text).html_safe
    end
end
