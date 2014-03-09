Crunchyroll
===========
Find and get infos about series airing on Crunchyroll.

Install
------
`$ gem install crunchyroll`

Example
-------
A complete example is available [https://github.com/RoxasShadow/Descartes/blob/master/lib/descartes/modules/crunchyroll.rb](here),

```ruby
require 'crunchyroll'

puts "Pupa airs in #{Crunchyroll.get('pupa')[:left]}."
p    Crunchyroll.today
```

The time zone of the sources is PDT (UTC -007). `Crunchyroll::get` and `Crunchyroll::today` accept an optional parameter `time_diff` that is set by default to `8` (UTC +001).
