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
    diff  = TimeDifference.between(self, end_time).in_general
    
    secs  = diff[:seconds].to_i
    mins  = diff[:minutes].to_i
    hours = diff[:hours  ].to_i
    days  = diff[:days   ].to_i

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

  def add_hours(n = 1)
    self + (n * 60 * 60)
  end
end

class String
  def to_24h
    DateTime.parse(self).strftime("%H:%M")
  end

  def format_cr_date
    s = ''
    self.split('Simulcast on ')[1][0..-5].split.each { |d| s += d.end_with?(?s) ? d[0..-2] : d; s += ' ' }
    
    am_pm = s.strip[-2..-1]
    s     = s.strip[0..-3]

    day_time = s.split
    day      = day_time.shift
    time     = day_time.shift.to_24h
    return "#{day} #{time}"
  end
end