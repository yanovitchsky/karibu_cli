# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "karibu_cli/version"

Gem::Specification.new do |spec|
  spec.name          = "karibu_cli"
  spec.version       = KaribuCli::VERSION
  spec.authors       = ["Yann Akoun"]
  spec.email         = ["yann@visibleo.fr"]

  spec.summary       = %q{RPC client protocol Karibu}
  spec.description   = %q{RPC client protocol Karibu.}
  spec.homepage      = "http://visibleo.fr"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "concurrent-ruby"
  spec.add_dependency "msgpack"
  spec.add_dependency "ffi-rzmq"
  # spec.add_dependency "thor"
  # spec.add_dependency 'classify'
  spec.add_dependency 'log4r'
end
