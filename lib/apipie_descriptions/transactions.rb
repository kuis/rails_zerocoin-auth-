module ApipieDescriptions::Transactions

  def apipie_transactions_create
    api :POST, '/transactions', '[PUBLIC] Transactions.'
    param :amount,  Integer, required: true
    
    description <<-EOS
      If successful, it returns an <tt>access_token</tt> required by all
      subsequent requests, with status <tt>200</tt>.
      If unsuccessful, it returns status <tt>401</tt>.
    EOS
  end

end
