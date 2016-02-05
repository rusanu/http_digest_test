module HttpDigestTest
  class Engine < ::Rails::Engine
    initializer :http_digest_test_concerns do |app|
      ActionController::TestCase.send(:include, HttpDigestTest::ActionControllerTestCaseConcern)
    end
  end
end
