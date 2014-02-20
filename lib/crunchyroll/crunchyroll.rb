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
class << self

  def find(series)
    url   = ''
    title = ''
    cr    = 'http://www.iamalittlekitty.info/index.php?q=aHR0cDovL3d3dy5jcnVuY2h5cm9sbC5jb20vbGluZXVw&hl=3ed'
    Nokogiri::HTML(open(cr)).xpath('//a[@class="portrait-element block-link titlefix element-lineup-anime"]').each { |r|
      if r['title'].downcase.include? series.downcase
        title = r['title']
        url   = r['href' ]
        break
      end
    }
    return false if title.empty? || url.empty?
    
    air         = Nokogiri::HTML(open(url)).xpath('//ul[@id="sidebar_elements"]/li').select { |e| e.at_xpath('.//p[@class="strong"]') }[0].text
    day_literal = air.split('Simulcast on ')[1].split(' ')[0][0..-2]
    date        = Time.parse(air.format_cr_date).add_hours 8
    date        = Chronic.parse("this #{day_literal} at #{date.hour}:#{date.min}")

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

  def today
    url = 'http://horriblesubs.info/release-schedule/'
    [].tap { |releases|
      Nokogiri::HTML(open(url)).xpath('//div[@class="today-releases"]/div[@class="series-name"]').each { |r|
        title = r.at_xpath('.//child::text()').to_s.squeeze(' ')
        time  = r.at_xpath('.//span').text
        date  = Time.parse(time).add_hours 9

        releases << {
          :title => title,
          :where => 'Crunchyroll',
          :day   => Time.now.strftime("%A"),
          :hour  => date.hour,
          :min   => date.min,
          :left  => Time.now.left(date)
        }
      }
    }
  end

end
end