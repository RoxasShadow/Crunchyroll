class DateTime
  def time_left(date)
    a = self.to_time - 1*60*60    
    secs  = (a - date.to_time).to_int
    mins  = secs / 60
    hours = mins / 60
    days  = hours / 24

    "#{days} days, #{hours % 24} hours, #{mins % 60} minutes and #{secs % 60} seconds"
  end
  
  def date_of_next
    delta = self > DateTime.now ? 0 : 7
    self + delta
  end
end

class Fixnum
  def fix
    self > 9 ? self.to_s : "0#{self}"
  end
end