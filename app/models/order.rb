class Order < ApplicationRecord
  #validations
  validates :cust_name, presence: true, format: { with: /[a-zA-Z]/ }, on: :create
  validates :cc_digit, presence: true, format: { with: /\b\d{4}[ -]?\d{4}[ -]?\d{4}[ -]?\d{4}\b/ }, on: :create
  validates :cc_expiration, presence: true, on: :create
  validates :cc_cvv, presence: true, format: { with: /[0-9]{3}/ }, on: :create
  validates :cc_zip, presence: true, format: { with: /[0-9]{5}/ }, on: :create
  validates :cust_email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, on: :create 
  validates :mailing_address, presence: true, on: :create
  #relationships

  has_many :order_items


  def total_price
    order_items.collect { |order_item| order_item.quantity * order_item.unit_price }.sum

  end

  def place_order
    # self.products.each decrease inventory
      # find qty in OrdersProducts by order_id & product_id

    # self.order = "paid"

    # clears current cart ()

  end


  def date_of_order
    return self.created_at.strftime("%B %d, %Y")
  end

  private

    # def set_order_status
    #   self.order_status_id = 1
    # end


end
