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
  def time_left(date)
    secs  = (self - date).to_i
    mins  = secs  / 60
    hours = mins  / 60
    days  = hours / 24

    if    days  >  0
      "#{days} days, #{hours % 24} hours, #{mins % 60} minutes and #{secs % 60} seconds"
    elsif hours >  0
      "#{hours % 24} hours, #{mins % 60} minutes and #{secs % 60} seconds"
    elsif mins  >  0
      "#{mins % 60} minutes and #{secs % 60} seconds"
    elsif secs  >= 0
      "#{secs % 60} seconds"
    end
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