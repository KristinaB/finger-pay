# webapp
require_relative 'env'

class Realhack < Sinatra::Base

  @@status = nil
  
  def payment_status
    @@status
  end

  get '/' do
    haml :index
  end

  get '/payment_status' do
    # the payment status resets every 30 seconds just for demo purposes
    content_type :json
    { success: true, status: payment_status }.to_json
  end

  # this should be a post - we should be using the native SDK for logbar ring to make post request but it's available only on iOS at the moment and we wanted to make a cross platform app
  get '/pay/:product_id' do |product_id|
    content_type :json
    p = Payment.new
    transaction = p.pay product_id.to_sym
    @@status = :paid
    Thread.new {
      sleep 30
      @@status = nil
    }
    { success: true, transaction: transaction }.to_json
  end
end
