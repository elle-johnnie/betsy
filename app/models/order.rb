class Order < ApplicationRecord
  #validations
  validates :cc_digit, presence: true, numericality: { only_integer: true, is: 16}
  validates :cc_expiration, presence: true, numericality: { only_integer: true, greater_than: 2018}
  # validates :publication_year, presence: true, numericality: { only_integer: true, greater_than: 0,  less_than: 2019}
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
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
