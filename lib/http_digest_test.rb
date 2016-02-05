require "http_digest_test/version"
require "http_digest_test/action_controller_test_case_concern.rb"
require "http_digest_test/engine"

module HttpDigestTest

  class << self
    mattr_accessor :http_digest_realm

    def config
      yield self
    end
  end

end
