class Public::LikeListsController < ApplicationController

  def create
    @item = Item.find(params[:item_id])
    like_list = current_customer.like_lists.new(item_id: @item.id)
    like_list.save
  end

  def destroy
    @item = Item.find(params[:item_id])
    like_list = current_customer.like_lists.find_by(item_id: @item.id)
    like_list.destroy
  end
end
