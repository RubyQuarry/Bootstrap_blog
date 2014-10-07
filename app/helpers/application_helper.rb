module ApplicationHelper


  def date_format(obj)
    day = obj.created_at.day.ordinalize
    obj.created_at.strftime("%A, %B #{day} %Y") # => "{ Name of day , Month , day , year }"
  end

  def month_year_convertor(arr)
    "#{Date::MONTHNAMES[arr[0]]} #{arr[1]}"
  end
end
