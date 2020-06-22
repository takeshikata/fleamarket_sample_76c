class CardsController < ApplicationController

  require "payjp"
  before_action :set_parent, except: [:delete]
  before_action :set_card

  def new
    @user = User.find(current_user.id)
    card = Card.where(user_id: current_user.id)
    redirect_to card_path(current_user.id) if card.exists?
    @profile = Profile.find(current_user.id)
  end
  
  def create
    #payjpとCardのデータベース作成
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    #保管した顧客IDでpayjpから情報取得
    if params['payjp-token'].blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(
        description: 'test',
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
        )
        @card = Card.new(user_id: current_user.id, payjp_id: customer.id)
        if @card.save
          redirect_to card_path(current_user.id)
        else
          redirect_to new_card_path
        end
      end
    end
    
    def destroy
      #PayjpとCardデータベースを削除
      card = Card.find_by(user_id: current_user.id)
      if card.blank?
      else
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        customer = Payjp::Customer.retrieve(@card.payjp_id)
        customer.delete
        card.delete
      end
      redirect_to new_card_path
    end
    
    def show
      #Cardのデータpayjpに送り情報を取り出す
    @user = User.find(current_user.id)
    @profile = Profile.find(current_user.id)
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to new_card_path 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.payjp_id)
      @default_card_information = customer.cards.retrieve(customer.default_card)
    end
  end

  private
  def set_parent
    @parents = Category.all.order("id ASC").limit(10)
  end
  
  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end

end