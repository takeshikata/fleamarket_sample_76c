require 'rails_helper'
# require 'faker'

describe ProductsController, type: :controller do

  describe 'GET #search' do
    it "match the products" do
      keyword = "a"
      user = create(:user)
      100.times{create(:product,user: user)}
      products = Product.where(["name LIKE(?)", "%#{keyword}%"])
      get :search, params: {search_form: {keyword: keyword}}
      expect(assigns(products)).to eq(@products)
    end

    it "search.html.hamlに遷移すること" do
      get :search, params: {  keyword: "a" }
      expect(response).to render_template :search
    end
  end
end
