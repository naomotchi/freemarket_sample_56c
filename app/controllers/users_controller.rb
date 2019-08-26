class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :card_add_to]
  before_action :set_header
  before_action :set_item, only: [:show, :listing, :trading, :completed, :purchase, :purchased, :things]
  before_action :set_card, only: [:card_add_to]

  def show
  end

  def user_card
    gon.payjp_key = ENV["PAYJP_KEY"]
  end

  def card_add_to
  end

  def things
  end

  def listing
  end

  def trading
  end

  def completed
  end

  def purchase
  end

  def purchased
  end

  private

  def set_item
    @item_seller = Item.with_attached_images.where(seller_id: current_user.id).where(buyer_id: nil).order("id DESC").limit(10)
    @item_buyer = Item.with_attached_images.where(buyer_id: current_user.id).order("id DESC").limit(5)
    @completed =  Item.with_attached_images.where(seller_id: current_user.id).where("buyer_id > ?", 1).order("id DESC").limit(10)
    @user = User.where(id: @completed.map{|hash| hash[:buyer_id]})
  end

  def set_card
    @card = Card.where(params[:user_id])
  end

  def set_header
    @categories1 = Category.where(parrent_id: 0)
    @categories2 = Category.where(parrent_id: Category.where(parrent_id: 0).ids).group_by(&:parrent_id)
    @categories3 = Category.where(parrent_id: Category.where(parrent_id: Category.where(parrent_id: 0).ids).ids).group_by(&:parrent_id)
  end
end
