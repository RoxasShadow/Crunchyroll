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

module Crunchyroll
module Utils
  class << self
    def time_left(start_time, end_time)
      diff  = TimeDifference.between(start_time, end_time).in_general

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

    def format_cr_date(date)
      s = ''
      date.split('Simulcast on ')[1][0..-5].split.each { |d| s += d.end_with?(?s) ? d[0..-2] : d; s += ' ' }

      am_pm = s.strip[-2..-1]
      s     = s.strip[0..-3]

      day_time = s.split
      day      = day_time.shift
      time     = DateTime.parse(day_time.shift).strftime('%H:%M')
      "#{day} #{time}"
    end
  end
end
end
