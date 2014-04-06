Crunchyroll
===========
Find and get infos about series airing on [Crunchyroll](http://www.crunchyroll.com).

Install
------
`$ gem install crunchyroll`

Example
-------
A complete example is available [https://github.com/RoxasShadow/Descartes/blob/master/lib/descartes/modules/crunchyroll.rb](here),

```ruby
require 'crunchyroll'

puts "Nisekoi airs in #{Crunchyroll.get('Nisekoi')[:left]}."
p    Crunchyroll.today
```

The time zone of the sources is `MST` (UTC -007).
`Crunchyroll::get` and `Crunchyroll::today` accept an optional parameter `time_zone` that is set by default to `Rome`.