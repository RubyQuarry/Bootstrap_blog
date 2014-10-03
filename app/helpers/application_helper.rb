module ApplicationHelper


  def date_format(obj)
    day = obj.created_at.day.ordinalize
    obj.created_at.strftime("%A, %B #{day} %Y") # => "{ Name of day , Month , day , year}"
  end
end
