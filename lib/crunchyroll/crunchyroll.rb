module Crunchyroll
  def self.find(series)
    begin
      url   = ''
      title = ''
      cr    = 'http://www.uswebproxy.com/index.php?q=aHR0cDovL3d3dy5jcnVuY2h5cm9sbC5jb20vbGluZXVw&hl=3ed'
      Nokogiri::HTML(open(cr)).xpath('//div[@class="anime-grid-item"]').each { |r|
        tmp  = r.xpath('.//a/div/text()').to_s
        if tmp.downcase.include? series.downcase
          title = tmp
          url   = r.xpath('.//a/@href').to_s
          break
        end
      }
      return false if title.empty? || url.empty?
      
      air  = Nokogiri::HTML(open(url)).xpath('//ul[@id="sidebar_elements"]/li')[1].xpath('.//p')[0].text

      day_literal = air.split('Simulcast on ')[1].split(' ')[0]
      date        = DateTime.parse(air.split('Simulcast on ')[1]).date_of_next

      return {
        :title => title,
        :where => 'Crunchyroll',
        :day   => day_literal,
        :hour  => date.hour.fix,
        :min   => date.min.fix,
        :left  => date.time_left(DateTime.now)
      }
    rescue
      return false
    end
  end
end