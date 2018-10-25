class User < ApplicationRecord
  # validations
  validates :username, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: {scope: :provider}
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  # relationships
  has_many :products
  has_many :order_items, through: :products

  def self.new_user(auth_hash)
    new_user = User.new(email: auth_hash[:info][:email],
                        username: auth_hash[:info][:nickname],
                        uid: auth_hash[:uid],
                        provider: 'github')

    return new_user
  end


  def find_orders
    sold = []
    self.products.each do |product|
      if !product.order_items.empty?
        sold << product
      end
    end

    return sold
  end


  def revenue(status_filter)
    case status_filter
      when "Pending"
        rev = self.orders.where(status: "Pending").order_items.subtotal.sum
      when "Paid"
        rev = self.orders.where(status: "Paid").order_items.subtotal.sum
      when "Completed"
        rev = self.orders.where(status: "Complete").order_items.subtotal.sum
      when "Cancelled"
        rev = self.orders.where(status: "Cancelled").order_items.subtotal.sum
      when "Total"
        rev = self.orders.order_items.subtotal.sum - self.orders.where(status: "Cancelled").order_items.subtotal.sum
    end

    return rev
  end


end
