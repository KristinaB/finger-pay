require 'realex'
require 'rest-client'


require_relative 'customer_data'
require_relative 'products'

RealEx::Config.shared_secret = 'secret'
RealEx::Config.merchant_id   = 'hackathon27'


CURRENT_CUSTOMER = Customer.instance name: 'Kristina B.'
CUSTOMER = CURRENT_CUSTOMER

class Payment
  def create_transaction(amount:)
    RealEx::Authorization.new customer_number: 2345, variable_reference: 2345, card: CUSTOMER[:card], amount: amount, order_id: rand(999999), currency: 'GBP', autosettle: true
  end

  def pay(product)
    product = PRODUCTS[product]
    transaction = create_transaction amount: product[:amount]
    transaction.comments << "Bought '#{product[:name]}' with FingerPay"
    sleep 10
    transaction.authorize!
    transaction.to_xml
  end
end

# -----------------------

# debug and test code:
#

# puts transaction.to_xml
# transaction.to_xml
# p transaction

# remote_url = "https://epage.payandshop.com/epage-remote.cgi"
# tx = transaction.to_xml
#
# resp = RestClient.post remote_url, tx
# puts resp.body
#
# transaction.authorize!
