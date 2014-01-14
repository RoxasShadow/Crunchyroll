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
  def self.find(series)
      url   = ''
      title = ''
      cr    = 'http://www.uswebproxy.com/index.php?q=aHR0cDovL3d3dy5jcnVuY2h5cm9sbC5jb20vbGluZXVw&hl=3ed'
      Nokogiri::HTML(open(cr)).xpath('//a[@class="portrait-element block-link titlefix element-lineup-anime"]').each { |r|
        if r['title'].downcase.include? series.downcase
          title = r['title']
          url   = r['href' ]
          break
        end
      }
      return false if title.empty? || url.empty?
      
      air         = Nokogiri::HTML(open(url)).xpath('//ul[@id="sidebar_elements"]/li')[1].xpath('.//p')[0].text
      day_literal = air.split('Simulcast on ')[1].split(' ')[0]
      date        = Chronic.parse("this #{air.format_cr_date}").add_hours 9

      return {
        :title => title,
        :where => 'Crunchyroll',
        :day   => day_literal,
        :hour  => date.hour.to_24h,
        :min   => date.min.to_24h,
        :left  => Time.now.left(date)
      }
  end
end

Crunchyroll::find 'Nisekoi'