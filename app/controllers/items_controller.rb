class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :move_to_index, only: [:edit, :destroy]
  before_action :check_order, only: [:edit]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  def index
    @items = Item.all.order(created_at: :DESC)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :describe, :image, :category_id, :status_id, :area_id, :day_id, :fee_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    item = Item.find(params[:id])
    unless user_signed_in? && current_user.id == item.user_id
      redirect_to action: :index
    end
  end

  def check_order
    item = Item.find(params[:id])
    if item.order != nil
      redirect_to root_path
    end
  end
end
