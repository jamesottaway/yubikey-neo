# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'yubikey-neo'
  spec.version       = '0.0.1'
  spec.authors       = ['James Ottaway']
  spec.email         = ['rubygems@james.ottaway.io']
  spec.summary       = 'Securely manage your 2FA tokens using your Yubikey NEO'
  spec.homepage      = 'https://github.com/jamesottaway/yubikey-neo'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
