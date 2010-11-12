# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "local_cdn"
  s.version     = File.read(File.dirname(__FILE__) + '/VERSION')
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alex Reisner"]
  s.email       = ["alex@alexreisner.com"]
  s.homepage    = "http://github.com/alexreisner/local_cdn"
  s.date        = Date.today.to_s
  s.summary     = "Load your Rails app's CDN content locally when not connected to the Internet."
  s.description = "Rails plugin which allows you to use a CDN in production but seamlessly load assets from localhost in development. Great for when you don't have an Internet connection, like when you're on a plane."
 
  s.files         = Dir.glob("{lib}/*") + %w(Rakefile README.rdoc MIT-LICENSE)
  s.require_paths = ["lib"]
end
