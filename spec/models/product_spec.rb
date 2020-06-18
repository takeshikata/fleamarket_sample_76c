require 'rails_helper'

describe Product, type: :model do
  describe '#create' do
    it "商品名がない場合は登録できないこと" do
      product = Product.new(name: "")
      product.valid?
      expect(product.errors[:name]).to include("can't be blank")
    end
  end

  describe '#create' do
    it "商品説明がない場合は登録できないこと" do
      product = Product.new(introduction: "")
      product.valid?
      expect(product.errors[:introduction]).to include("can't be blank")
    end
  end

  describe '#create' do
    it "カテゴリー情報がない場合は登録できないこと" do
      product = Product.new(category_id: "")
      product.valid?
      expect(product.errors[:category]).to include("must exist")
    end
  end

  describe '#create' do
    it "商品状態の情報がない場合は登録できないこと" do
      product = Product.new(product_condition_id: "")
      product.valid?
      expect(product.errors[:product_condition]).to include("must exist")
    end
  end

  describe '#create' do
    it "発送元の地域情報がない場合は登録できないこと" do
      product = Product.new(shipping_region_id: "")
      product.valid?
      expect(product.errors[:shipping_region]).to include("must exist")
    end
  end

  describe '#create' do
    it "発送までの発送日数の情報がない場合は登録できないこと" do
      product = Product.new(preparation_term_id: "")
      product.valid?
      expect(product.errors[:preparation_term]).to include("must exist")
    end
  end

  describe '#create' do
    it "価格情報がない場合は登録できないこと" do
      product = Product.new(price: "")
      product.valid?
      expect(product.errors[:price]).to include("can't be blank")
    end
  end
end
