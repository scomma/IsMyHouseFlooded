class DateTime
  def beginning_of_hour
    change min: 0
  end
end

class Time
  def beginning_of_hour
    change min: 0
  end
end
