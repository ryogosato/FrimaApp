class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :destroy, :pay, :confirm, :done]

  require 'payjp'

  def index
    @items = Item.all.limit(12)
    @images = Image.all
    @image = @images.where(item_id: @items.ids)
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
    @user = User.find_by(id: @item.user_id)
    @images = Image.where(item_id: @item.id)
    @shipping_day = @item.shipping_days
    @area = @item.area
    @brand = Brand.find(@item.brand_id)
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
    if @item.update( purchase_id: current_user.id)
      redirect_to action: 'done' #完了画面に移動
    else
      render :confirm
    end
  end

  def new
    @item = Item.new
    @brands = Brand.all
    @category_parent_array = ["指定なし"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
    @item.images.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save && @item.images.count != 0
      @image = @item.images.create
      redirect_to :root
    else
      flash.now[:alert] = '画像を１枚以上添付してください'
      render :new
    end
  end

  def edit
    # @images = Image.where(item_id: @item.id)
    # num = 0
    # while num <= @item.images.count do
    #   @image = Image.find_by(item_id: @item.id)
    #   num += 1
    # end
    @images = @item.images
    @brands = Brand.all
    # @brand = Brand.find(id: @item.brand_id)
    @category_parent_array = ["指定なし"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
    
    @item.images.build
    # binding.pry
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      flash.now[:alert] = '画像を１枚以上添付してください'
      render :edit
    end
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
    params.require(:item).permit(
      :name, :description, :price, :brand_id, :area, :condition, :fee,
      :shipping_days, images_attributes: [:content, :id, :_destroy]
      ).merge(user_id: current_user.id, category_id: params[:category_id], brand_id: params[:item][:brand_id])
  end

  

  def set_item
    @item = Item.find(params[:id])
  end
end