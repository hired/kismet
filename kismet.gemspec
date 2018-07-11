
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kismet/version'

Gem::Specification.new do |spec|
  spec.name          = 'kismet'
  spec.version       = Kismet::VERSION
  spec.authors       = ['Danny Vink']
  spec.email         = ['daniel.vink@hired.com']

  spec.summary       = 'Offers a quick way to dump data to a AWS Kinesis stream'
  spec.description   = 'Kismet offers a quick way to dump data to a AWS Kinesis stream'
  spec.homepage      = 'http://github.com/hired/kismet'
  spec.license       = 'MIT'

  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'aws-sdk-kinesis', '~> 1.3'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
