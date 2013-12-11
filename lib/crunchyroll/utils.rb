##
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
# 
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
# 
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
# 
#  0. You just DO WHAT THE FUCK YOU WANT TO.
##

class Time
  def time_left(start_time)
    diff  = TimeDifference.between(start_time, self.add_day).in_general
    
    secs  = diff[:seconds].to_i
    mins  = diff[:minutes].to_i
    hours = diff[:hours].to_i
    days  = diff[:days].to_i

    if days > 0
      "#{days} days, #{hours} hours, #{mins} minutes and #{secs} seconds"
    elsif hours >  0
      "#{hours} hours, #{mins} minutes and #{secs} seconds"
    elsif mins  >  0
      "#{mins} minutes and #{secs} seconds"
    elsif secs  >= 0
      "#{secs} seconds"
    end
  end

  def add_day(n = 1)
    self + (n * 24 * 60 * 60)
  end
  
  def date_of_next
    date  = self + 9 / 24.0 # proxy is PST
    delta = date > Time.now ? 0 : 7
    date + delta
  end
end

class Fixnum
  def fix
    self > 9 ? self.to_s : "0#{self}"
  end
end