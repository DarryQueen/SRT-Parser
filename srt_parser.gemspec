Gem::Specification.new do |s|
  s.name        = 'srt_parser'
  s.version     = '0.0.1'
  s.date        = '2015-04-01'
  s.summary     = 'SRT cover parser.'
  s.description = "A simple gem to parse how much of a video an SRT file covers."
  s.authors     = ['Darren Zhao']
  s.email       = 'darryqueen@berkeley.edu'
  s.files       = ['lib/srt_parser.rb']
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/DarryQueen/SRT-Parser'

  s.add_runtime_dependency 'srt', '~> 0.1', '>= 0.1.2'
end
