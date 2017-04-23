# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/booker/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'omniauth-oauth2', '~> 1.1', '<= 1.3.1'
  spec.add_dependency 'jwt', '~> 1.5.2'
  spec.name         = 'omniauth-booker'
  spec.version     = OmniAuth::Booker::VERSION
  spec.date        = '2017-01-01'
  spec.summary     = 'Booker OmniAuth Strategy'
  spec.description = 'OmniAuth strategy for the Booker API using OAuth2'
  spec.authors     = ['Frederick']
  spec.email       = 'tech@hirefrederick.com'
  spec.files       = %w(omniauth-booker.gemspec)
  spec.files       += Dir.glob('lib/**/*.rb')
  spec.homepage    = 'https://github.com/hirefrederick/omniauth-booker'
  spec.licenses    = %w(MIT)

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rspec'
end
