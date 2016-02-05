# HttpDigestTest

Adds HTTP Digest support for Rails controller test cases.

## Installation

Add this lines to your Rails project Gemfile:

```ruby
group :test do
  get 'http_digest_test'
end
```

And the execute:

  $ bundle

## Usage

Create an initializer and set the HTTP digest realm your controllers use:

```ruby
HttpDigestTest.config do |config|
  config.http_digest_realm = 'mykillerapp.com'
end
```

In your controller test, add `http_digest_test` at the class level, then prefix each action call with `authenticate_http_digest username, password`:

```ruby
class PostsControllerTest < ActionController::TestCase
  http_digest_test

  test 'Should get with authentication' do
    authenticate_http_digest 'username', 'password'
    get :index
    assert_response :success
  end

  test 'Should deny wrong password' do
    authenticate_http_digest 'username', 'incorrect'
    get :index
    assert_response :unauthorized
  end
  
  test 'Should deny no password' do
    get :index
    assert_response :unauthorized
  end
end
```

## How it works

Examples of how to use HTTP Digest authentication exist, eg. http://lightyearsoftware.com/2009/04/testing-http-digest-authentication-in-rails/, but not packed as a reusable gem.
This implementation does not do an extra round-trip to the controller to get the HTTP Digest challenge. It uses knowlege of how `ActionController::HttpAuthentication::Digest` formats the nonce and opaque components of the HTTP Digest challenge and formats a valid response. Corrolary this will not work if you use a different HTTP Digest challenge implementation than the stock ` ActionController::HttpAuthentication::Digest`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
