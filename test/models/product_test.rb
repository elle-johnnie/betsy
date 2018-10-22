require "test_helper"

describe Product do
  # let(:product) { Product.new }

  describe "validation" do

    it "must be valid" do
      2.times do
        product = create(:product)
      end

      expect(product.valid?).must_equal true
    end

    it "must be invalid without a category " do
      1.times do
        product = create(:product)
      end

      product.category = nil

      expect(product.category.valid?).must_equal false
      expect(product.errors.messages).must_include :category
    end

    it "must be invalid without a product name " do
      1.times do
        product = create(:product)
      end
      product.prod_name = nil

      expect(product.prod_name.valid?).must_equal false
      expect(product.errors.messages).must_include :prod_name
    end

    it "must be a string for product name " do
      1.times do
        product = create(:product)
      end
      product.prod_name = 123

      expect(product.prod_name.valid?).must_be_instance_of String
      expect(product.errors.messages).must_include :prod_name
    end

    it "must be invalid without a description" do
      1.times do
        product = create(:product)
      end

      product.description = nil

      expect(product.description.valid?).must_equal false
      expect(product.errors.messages).must_include :description
    end


    it "must be invalid without a price" do
      1.times do
        product = create(:product)
      end

      product.price = nil

      expect(product.price.valid?).must_equal false
      expect(product.errors.messages).must_include :price
    end


    it "must have a unique name for each product" do
      product = products(:one)
      product2 = products(:one)

      expect(product2.prod_name.valid?).must_equal false
    end
  end


  describe "relations" do

    it "belong to a user" do
      product = user.product
      #add the yml file
      expect(product).must_be_instance_of User
      expect(product.id).must_equal user.product_id
    end

    it "can have a rating" do
      product = rating.product
      expect(product).must_be_instance_of Review
      expect(product.id).must_equal review.product_id
    end

  end
end
