class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :destroy, :pay, :confirm, :done]

  require 'payjp'

  def index
    @items = Item.all.limit(12)
    @images = Image.all
    @image = @images.where(item_id: @items.ids)
  end

  def show
    @images = Image.where(item_id: @item.id)
    @shipping_day = Item.shipping_days.keys[@item.shipping_days-1]
    @area = Item.prefectures.keys[@item.area-1]
    @brand = Brand.find(@item.brand_id)
    @favorite = Favorite.all
    @favorites = @favorite.where(item_id: @item.id).count
  end

  def confirm
    @images = Image.where(item_id: @item.id)
    card = Card.where(user_id: current_user.id).first
    #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
    if card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to controller: "card", action: "new"
    else
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def done
    @images = Image.where(item_id: @item.id)
  end

  def pay
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
    Payjp::Charge.create(
    :amount => @item.price, #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => card.customer_id, #顧客ID
    :currency => 'jpy', #日本円
      )
    @item.update( purchase_id: current_user.id)
    redirect_to action: 'done' #完了画面に移動
  end

  def new
    @item = Item.new
    @brands = Brand.group(:name)
    @category_parent_array = ["指定なし"]
    Category.where(ancestry: nil).each do |parent|
       @category_parent_array << parent.name
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :condition, :fee, :area, :shipping_days, brand: [:name, :id]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
