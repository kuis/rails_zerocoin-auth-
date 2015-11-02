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
    api :POST, "/passwords", "Change user password."
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
    api :DELETE, "/passwords/:id", "Delete."
    param :id, Integer
    description <<-EOS
      Always returns status <tt>204</tt>.
    EOS
    apipie_clear(__method__)
  end
end
