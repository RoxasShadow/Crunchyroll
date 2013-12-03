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