# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "local_assets"
  s.version     = File.read(File.join(File.dirname(__FILE__), 'VERSION'))
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alex Reisner"]
  s.email       = ["alex@alexreisner.com"]
  s.homepage    = "http://github.com/alexreisner/local_assets"
  s.date        = Date.today.to_s
  s.summary     = "Load your Rack app's assets locally when not connected to the Internet."
  s.description = "Allows you to use a CDN in production but seamlessly load assets from localhost in development. Great for when you don't have an Internet connection, like when you're on a plane."
 
  s.files         = `git ls-files`.split("\n") - %w[local_assets.gemspec Gemfile init.rb]
  s.require_paths = ["lib", "lib/rack"]
end
