module HttpDigestTest
  module ActionControllerTestCaseConcern
    extend ActiveSupport::Concern

    module ClassMethods
      
      def http_digest_test
        self.class_eval do
          alias_method :process_http_digest_test, :process

          def process(action, *args)
            if @__username
              method = args[0] if args[0].is_a?(String)
              method = args[0][:method] if args[0].is_a?(Hash)
              @request.env['HTTP_AUTHORIZATION'] = encode_credentials(
                username: @__username,
                password: @__password,
                uri: @request.env['REQUEST_URI'] || action,
                method: method)
              @__username = @__password = nil
            end
            process_http_digest_test action, *args
          end

          def authenticate_http_digest(username, password)
            @__username = username
            @__password = password
          end

          private

          def encode_credentials(options)
            key_generator = Rails.application.key_generator
            http_auth_salt = Rails.application.config.action_dispatch.http_auth_salt
            secret_token = key_generator.generate_key http_auth_salt
            password = options.delete(:password)
            method = options.delete(:method) || 'GET'
            uri = options[:uri]
            realm = HttpDigestTest.http_digest_realm || 'Application'

            nonce = ActionController::HttpAuthentication::Digest.nonce secret_token
            opaque = ActionController::HttpAuthentication::Digest.opaque secret_token

            options.reverse_merge! nc: '00000001', 
              cnonce: '0a4f113b', 
              password_is_ha1: false,
              qop: 'auth',
              realm: realm,
              nonce: nonce,
              opaque: opaque

            ActionController::HttpAuthentication::Digest.encode_credentials method, options, password, false
          end
        end

      end

    end
  end
end
