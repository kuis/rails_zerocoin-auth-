module ApipieDescriptions::Passwords
  def apipie_passwords_index
    apipie_clear(__method__)
  end

  def apipie_passwords_show
    api :GET, "/passwords/:id", "Retrieves a User object."
    param :id, Integer
    description <<-EOS
      If successful, it returns a <tt>user</tt> object based with
      status <tt>200</tt>.
    EOS

    apipie_clear(__method__)
  end


  def apipie_passwords_create
    api :POST, "/passwords", "[PUBLIC] Registers a new User."
    param :user, Hash, required: true do
      param :email, String, required: true
      param :password, String, required: true
      param :name, String, required: true
      param :verified, [true, false]
    end
    description <<-EOS
      If successful, it returns a <tt></tt> object with status <tt>201</tt>.
      If unsuccessful, it returns an errors hash with status <tt>400</tt>.
    EOS

    apipie_clear(__method__)
  end

  def apipie_passwords_destroy
    api :DELETE, "/passwords/:id", "Deletes a User."
    param :id, Integer
    description <<-EOS
      Always returns status <tt>204</tt>.
    EOS
    apipie_clear(__method__)
  end

  def apipie_passwords_reset_password
    api :POST, "/passwords/reset_password", "Reset a user's password."
    param :user, Hash, required: true do
      param :email, String, required: true
    end
    description <<-EOS
      If successful, it returns status <tt>200</tt> and sends an email to the
      user with a reset password token.
      If unsuccessful, it returns an errors hash with status <tt>400</tt>.
    EOS
    apipie_clear(__method__)
  end

  def apipie_passwords_verify_password_token
    api :POST, "/passwords/verify_password_token", "Verify a password reset token."
    param :user, Hash, required: true do
      param :reset_password_token, String, required: true
    end
    description <<-EOS
      If successful, it returns the User object and a new API authentication
      key.
      If unsuccessful, it returns Unauthorized <tt>401</tt>.
    EOS
    apipie_clear(__method__)
  end

  
  def apipie_passwords_resend_verification_email
    api :post, "/passwords/:id/resend_verification_email", "resend email verification email"
    param :id, Integer
    description <<-EOS
      If successful, it returns status 200.
      If unsuccessful, it returns No Content <tt>401</tt>.
    EOS
    apipie_clear(__method__)
  end

 
end
