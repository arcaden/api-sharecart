class Api::V1::CartsController < ApplicationController
    before_action :set_cart, only: [:show,:update,:destroy]

    def index
      @cart = Cart.user_carts(current_user)
      render json: @cart, status: :ok
    end
  
    def create
      @cart = Cart.create_cart(cart_params, current_user)
      render json: @cart, status: :ok
    end
  
    def show
      render json: @cart, status: :ok
    end
  
    def update
      @cart.update(cart_params)
      head :no_content
    end
  
    def destroy
      @cart.destroy
      head :no_content
    end
  
    private
  
    def set_cart
      @cart = Cart.find(params[:id])
    end
  
    def cart_params
      params.permit(:store_name, :created_by_id, :room_id)
    end
  
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  
    def render_unprocessable_entity_response(exception)
      render json: exception.record.errors, status: :unprocessable_entity
    end
  
    def render_not_found_response(exception)
      render json: { error: "cart not found" }, status: :not_found
    end
end
