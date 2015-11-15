module ApipieDescriptions::Users
  def apipie_users_index
    apipie_clear(__method__)
  end

  def apipie_users_show
    api :GET, "/users/:id", "Retrieves a User object."
    param :id, Integer
    description <<-EOS
      If successful, it returns a <tt>user</tt> object based with
      status <tt>200</tt>.
    EOS

    apipie_clear(__method__)
  end

  def apipie_users_create
    api :POST, "/users", "[PUBLIC] Registers a new User."
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

  def apipie_users_update
    api :POST, "/users", "[PUBLIC] Validate Credit Card."
    param :card_number, Integer, required:true
    param :expired_month, Integer, required:true
    param :expired_year, Integer, required:true
    param :cvc, String, required:true
  end

  def apipie_users_destroy
    api :DELETE, "/users/:id", "Deletes a User."
    param :id, Integer
    description <<-EOS
      Always returns status <tt>204</tt>.
    EOS
    apipie_clear(__method__)
  end

 
end
