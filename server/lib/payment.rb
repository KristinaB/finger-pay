require 'realex'
require 'rest-client'

RealEx::Config.shared_secret = 'secret'
RealEx::Config.merchant_id   = 'hackathon27'

OBJECTS = {
  shoes: { name: "shoes", amount: 80 },
  purse: { name: "purse", amount: 160 },
  drone: { name: "drone", amount: 120 },
}

card = RealEx::Card.new number: '4263970000005262', cvv: '509', expiry_date: '0822', cardholder_name: 'Paul Campbell', type: 'VISA'

transaction = RealEx::Authorization.new customer_number: 1234, variable_reference: 1234, card: card, amount: 2, order_id: rand(999999), currency: 'EUR', autosettle: true

transaction.comments << "Bought with Ring"

# puts transaction.to_xml
# transaction.to_xml
# p transaction

remote_url = "https://epage.payandshop.com/epage-remote.cgi"
tx = transaction.to_xml

resp = RestClient.post remote_url, tx
puts resp.body

transaction.authorize!
