Kernel.load 'lib/crunchyroll/version.rb'

Gem::Specification.new { |s|
  s.name          = 'crunchyroll'
  s.version       = Crunchyroll::version
  s.author        = 'Giovanni Capuano'
  s.email         = 'webmaster@giovannicapuano.net'
  s.homepage      = 'http://www.giovannicapuano.net'
  s.platform      = Gem::Platform::RUBY
  s.summary       = 'Find a series airing on Crunchyroll.'
  s.description   = 'Find and get infos about series airing on Crunchyroll.'
  s.licenses      = 'WTFPL'

  s.require_paths = ['lib']
  s.files         = Dir.glob('lib/**/*.rb')

  s.add_runtime_dependency 'nokogiri'
  s.add_runtime_dependency 'time_difference'
  s.add_runtime_dependency 'chronic'
  s.add_runtime_dependency 'activesupport'
}