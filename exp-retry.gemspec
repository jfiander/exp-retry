Gem::Specification.new do |s|
  s.name          = 'exp_retry'
  s.version       = '0.0.3'
  s.date          = '2018-10-16'
  s.summary       = 'Exponential backoff retry'
  s.description   = 'A simple exponential backoff retry wrapper.'
  s.homepage      = 'http://rubygems.org/gems/exp_retry'
  s.license       = 'GPL-3.0'
  s.authors       = ['Julian Fiander']
  s.email         = 'julian@fiander.one'
  s.require_paths = %w[lib spec doc]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")

  s.required_ruby_version = '~> 2.4'

  s.add_development_dependency 'rake',      '~> 12.2', '>= 12.2.1'
  s.add_development_dependency 'rspec',     '~> 3.7',  '>= 3.7.0'
  s.add_development_dependency 'simplecov', '~> 0.15', '>= 0.15.1'
end
