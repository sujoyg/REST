Gem::Specification.new do |s|
  s.name        = 'rest'
  s.version     = '0.0.1'
  s.date        = Time.now.to_date
  s.summary     = 'Toolkit for REST clients.'
  s.description = 'This gem provides a toolkit for REST clients.'
  s.authors     = ['Sujoy Gupta']
  s.email       = 'sujoyg@gmail.com'
  s.files       = Dir["lib/**/*"] + ["MIT-LICENSE"]
  s.homepage    = 'http://github.com/sujoyg/REST'
  s.license     = 'MIT'

  s.add_runtime_dependency 'rest-client', '1.8.0'
end
