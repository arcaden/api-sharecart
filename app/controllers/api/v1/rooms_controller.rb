class Api::V1::RoomsController < ApplicationController
  before_action :set_room,  only: [:show,:update,:destroy]

  def index
    @room = current_user.rooms(current_user.part_of_id)
    render json: @room, status: :ok
  end

  def create
    @room = current_user.join_room(room_params)
    render json: @room, status: :ok
  end

  def show
    render json: @room, status: :ok
  end

  def update
    @room.update(room_params)
    head :no_content
  end

  def destroy
    @room.destroy
    head :no_content
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    # whitelist params
    params.permit(:name)
  end

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_unprocessable_entity_response(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { error: "Room not found" }, status: :not_found
  end
end
