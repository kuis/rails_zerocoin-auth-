module ApipieDescriptions::Auth
  def apipie_auth_create
    api :POST, '/auth', '[PUBLIC] Authorizes a user account.'
    param :email,    String, required: true
    param :password, String, required: true
    description <<-EOS
      If successful, it returns an <tt>access_token</tt> required by all
      subsequent requests, with status <tt>200</tt>.
      If unsuccessful, it returns status <tt>401</tt>.
    EOS
  end

  def apipie_auth_destroy
    api :DELETE, '/auth/:id', 'Deauthorizes a user account.'
    param :id, String, required: true
    description 'Destroys Access Token for user.'
  end
end
