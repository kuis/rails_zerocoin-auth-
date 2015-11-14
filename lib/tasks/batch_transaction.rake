namespace :transaction do
  desc "Submit the settlement which are pending"
  task :multi_settlement => :environment do
    pending_transactions = Braintree::Transaction.search do |search|
      search.status.is Braintree::Transaction::Status::Authorized
    end
    total_amount = 0
    customer_id = nil
    pending_transactions.each do |transaction|
      puts transaction
      total_amount += transaction.amount
      customer_id = transaction.customer_details.id
      result = Braintree::Transaction.cancel_release(transaction.id)
    end
    result = Braintree::Transaction.sale(
      :amount => total_amount,
      :customer_id => customer_id,
      :options => {
        :submit_for_settlement => true    
      }
    )
  end
end
