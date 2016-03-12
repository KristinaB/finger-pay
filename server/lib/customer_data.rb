class CreditCard
  def self.instance(cardholder_name:)
    RealEx::Card.new number: '4263970000005262', cvv: '509', expiry_date: '0822', cardholder_name: cardholder_name, type: 'VISA'
  end
end

class Customer
  # CUST = Struct.new :name, :card

  def self.instance(name:)
    card = CreditCard.instance(cardholder_name: name)
    # CUST.new(
    {
      name: name,
      card: card
    }
  end
end
