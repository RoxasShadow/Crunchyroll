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

Time.zone          = 'MST'
Chronic.time_class = Time.zone

module Crunchyroll
class << self
  def find(series, time_zone = 'Rome', proxy = nil, use_proxy = true)
    proxy ||= { host: '136.0.16.217', port: '7808' }
    cr      = 'http://www.crunchyroll.com/lineup'

    title, url = [''] * 2
    Nokogiri::HTML(get_page(cr, proxy, use_proxy)).xpath('//a[@class="portrait-element block-link titlefix element-lineup-anime"]').each do |r|
      if r['title'].downcase.include? series.downcase
        title = r['title']
        url   = r['href' ]
        break
      end
    end

    return false if title.empty? || url.empty?

    air = Nokogiri::HTML(get_page(url, proxy, use_proxy)).xpath('//ul[@id="sidebar_elements"]/li').select { |e| e.at_xpath('.//p[@class="strong"]') }[0]
    return false unless air

    air         = air.text
    day_literal = air.split('Simulcast on ')[1].split[0][0..-2]
    date        = Time.parse(Utils.format_cr_date(air))
    date        = Chronic.parse("this #{day_literal} at #{date.hour}:#{date.min}").in_time_zone time_zone
    date       += 3600 unless Time.now.dst?

    {
      :title => title,
      :where => 'Crunchyroll',
      :day   => day_literal,
      :hour  => date.hour <= 9 ? "0#{date.hour}" : date.hour,
      :min   => date.min  <= 9 ? "0#{date.min}"  : date.min,
      :left  => Utils.time_left(Time.now, date)
    }
  end
    alias_method :get, :find

  def today(time_zone = 'Rome')
    url = 'http://horriblesubs.info/release-schedule/'
    tomorrow = Date.tomorrow
    today    = Time.now

    [].tap do |releases|
      Nokogiri::HTML(open(url)).xpath('//table[@class="schedule-table"]/tr').each { |r|
        title = r.at_xpath('.//td[@class="schedule-widget-show"]').text
        time  = r.at_xpath('.//td[@class="schedule-time"]').text

        date  = Chronic.parse("today at #{time}").in_time_zone(time_zone)
        date += 3600 unless today.dst?

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
          :left  => Utils.time_left(today, date)
        }
      }
    end.sort_by { |h| h[:date] }
  end

  def get_page(url, proxy, use_proxy)
    if use_proxy
      url = URI(url)
      Net::HTTP::Proxy(proxy[:host], proxy[:port]).start(url.host, url.port) { |r| r.request(Net::HTTP::Get.new(url.path)) }.body
    else
      open(url).read
    end
  end

end
end
