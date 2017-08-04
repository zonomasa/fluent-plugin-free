# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-free"
  spec.version       = "0.0.1"
  spec.authors       = ["TATEZONO Masaki"]
  spec.email         = ["tatezono@gmail.com"]
  spec.summary       = %q{Input plugin for fluentd to collect memory usage from free command.}
  spec.description   = %q{Input plugin for fluentd to collect memory usage from free command.}
  spec.homepage      = "https://github.com/zonomasa/fluent-plugin-free"
  spec.license       = "APLv2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit", "~> 3.2.0"
  spec.add_runtime_dependency "fluentd"
end
