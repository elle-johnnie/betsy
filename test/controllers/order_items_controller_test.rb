require "test_helper"

describe OrderItemsController do

  let (:product) { products(:cake1) }

  let (:order_item_hash1) {
    {
      order_item: {
        product_id: products(:cake3),
        qty: 5,
        shipped: true
      }
    }
  }

  let (:order_item_hash2) {
    {
      order_item: {
        product_id: product.id,
        qty: 3,
        shipped: true
      }
    }
  }

  describe 'create' do

    it 'can create a new order line item to existing order' do

      post order_items_path, params: order_item_hash1
      order_id = Order.last.id

      expect {
        post order_items_path, params: order_item_hash2
      }.must_change 'OrderItem.count', 1

      must_respond_with :redirect
      expect(OrderItem.last.product_id).must_equal product.id
      expect(OrderItem.last.order_id).must_equal order_id
    end

    it 'can create a new order line item when order does not already exist' do
    end

    it 'can not add a line order item if item is out of stock' do
    end

  end

  describe 'update' do

    it 'can update an existing order line item with valid data' do
    end

    it 'will not update an existing order line item with invalid data' do
    end

    it 'will render not_found when a line order item does not exist to update' do
    end

    it 'will will not update existing order line item when qty exceeds inventory count' do
    end

    it 'can not add a line order item if item is out of stock' do
    end

  end

  describe 'destroy' do

    it 'can delete an existing order line item' do
    end

    it 'will render not_found when a line order item does not exist to delete' do
    end

  end

  describe 'cart_direct' do

    it 'can add a line order item with a qty of 1 when existing order exists' do
    end

    it 'can add a line order item with a qty of 1 when existing order does not exist' do
    end

    it 'can not add a line order item if item is out of stock' do
    end
  end

end
