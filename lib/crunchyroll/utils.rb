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
  def left(end_time)
    diff  = TimeDifference.between(self, end_time.add_hour(9).add_day).in_general
    
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

  def add_hour(n = 1)
    self + (n * 60)
  end
end

class Fixnum
  def to_24h
    self > 9 ? self.to_s : "0#{self}"
  end
end

class String
  def format_cr_date
    s = ''
    self.split('Simulcast on ')[1][0..-5].split.each { |d| s += d.end_with?(?s) ? d[0..-2] : d; s += ' ' }
    s = s.strip[0..-3]

    day     = s.split[0]
    time    = s.split[1].split(?:)
    hours   = time[0].strip.to_i
    minutes = time[1]
    return "#{day} #{hours + 12}:#{minutes}"
  end
end