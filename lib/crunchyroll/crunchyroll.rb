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

using Utils

Time.zone          = 'MST'
Chronic.time_class = Time.zone

module Crunchyroll
class << self

  def find(series, time_zone = 'Rome', proxy = 'http://108.165.33.12:3128')
    ENV['http_proxy'] ||= proxy

    title, url = [''] * 2
    cr = 'http://www.crunchyroll.com/lineup'
    Nokogiri::HTML(open(cr)).xpath('//a[@class="portrait-element block-link titlefix element-lineup-anime"]').each do |r|
      if r['title'].downcase.include? series.downcase
        title = r['title']
        url   = r['href' ]
        break
      end
    end

    ENV.delete('http_proxy')

    return false if title.empty? || url.empty?

    air = Nokogiri::HTML(open(url)).xpath('//ul[@id="sidebar_elements"]/li').select { |e| e.at_xpath('.//p[@class="strong"]') }[0]
    return false unless air

    air         = air.text
    day_literal = air.split('Simulcast on ')[1].split[0][0..-2]
    date        = Time.parse(air.format_cr_date)
    date        = Chronic.parse("this #{day_literal} at #{date.hour}:#{date.min}").in_time_zone time_zone

    {
      :title => title,
      :where => 'Crunchyroll',
      :day   => day_literal,
      :hour  => date.hour <= 9 ? "0#{date.hour}" : date.hour,
      :min   => date.min  <= 9 ? "0#{date.min}"  : date.min,
      :left  => Time.now.left(date)
    }
  end
    alias_method :get, :find

  def today(time_zone = 'Rome')
    url = 'http://horriblesubs.info/release-schedule/'
    tomorrow = Date.tomorrow
    today    = Time.now

    [].tap do |releases|
      Nokogiri::HTML(open(url)).xpath('//div[@class="today-releases"]/div[@class="series-name"]').each { |r|
        title = r.at_xpath('.//child::text()').to_s.squeeze(' ')
        time  = r.at_xpath('.//span').text
        date  = Chronic.parse("today at #{time}").in_time_zone time_zone
        date -= 3600 if date.dst?

        time_diff = TimeDifference.between(today, date).in_general
        airs = if date.day == tomorrow.day && time_diff[:days] == 0
          :tomorrow
        else
          time_diff[:days] == 0 ? :today : :aired
        end

        releases << {
          :title => title,
          :where => 'Crunchyroll',
          :date  => date,
          :airs  => airs,
          :day   => date.strftime("%A"),
          :hour  => date.hour,
          :min   => date.min,
          :left  => today.left(date)
        }
      }
    end.sort_by { |h| h[:date] }
  end

end
end
