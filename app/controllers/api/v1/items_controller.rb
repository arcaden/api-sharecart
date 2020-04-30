class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :set_room, only: [:index, :create]

  def index
    @item = @cart.items
    render json: @item, status: :ok
  end

  def create
    @item = Item.create!(item_params.merge({requested_by_id: current_user.id, cart_id: @cart.id}))
    render json: @item, status: :ok
  end

  def show
    render json: @item, status: :ok
  end

  def update
    @item.update(item_params)
    head :no_content
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_room
    @cart = Cart.find(params[:cart_id])
  end

  def item_params
    params.permit(:name, :price, :description, :requested_by_id, :cart_id)
  end

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_unprocessable_entity_response(e)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def render_not_found_response(e)
    render json: { error: "Item not found" }, status: :not_found
  end
end
