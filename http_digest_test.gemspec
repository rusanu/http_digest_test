$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "http_digest_test/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "http_digest_test"
  s.version     = HttpDigestTest::VERSION
  s.authors     = ["Remus Rusanu"]
  s.email       = ["contact@rusanu.com"]
  s.homepage    = "hhtp://github.com/rusanu/http_digest_test"
  s.summary     = "HTTP Digest test suport for Rails controllers"
  s.description = "Add support for testing controllers that require HTTP digest."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]
end
