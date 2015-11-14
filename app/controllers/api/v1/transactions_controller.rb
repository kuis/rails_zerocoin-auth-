module Api::V1
  class TransactionsController < ApiController
    include ApipieDescriptions

    apipie_transactions_create
    def create
      if current_user.customer_id
        result = Braintree::Transaction.sale(
          :amount => params[:amount],
          :customer_id => current_user.customer_id,
          :options => {
            :submit_for_settlement => false
          }
        )

        if result.success?
          render :create, status: :ok
        elsif result.transaction
          render json: {error: result.transaction.processor_response_text}, status: 401
        end
      else
        render json: {error: "You have not verify your credit card."}, status: 401
      end
    end
  end
end