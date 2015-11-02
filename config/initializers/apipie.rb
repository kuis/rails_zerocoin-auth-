Apipie.configure do |config|
  config.app_name                = "Zero Coin"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/documentation"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
  config.validate                = false
  config.show_all_examples       = true
  config.reload_controllers      = Rails.env.development?
  config.app_info                = <<-EOS
    <b>Application Authentication</b>

    All Requests must be signed with an <tt>AUTHORIZATION</tt> header, unless
    marked [PUBLIC].

    This is a token provided during authentication and used to validate
    as well as identify users.

    E.g.,

      "AUTHORIZATION" => "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

    Any incorrectly authorized requests will return  <tt>message:
    'Invalid Authentication Token.'</tt> with status <tt>401</tt>.

    E.g.,
      {
        "success": false,
        "payload": {
          "status": 401,
          "message": "Invalid Authentication Token."
        }
      }
  EOS
end
