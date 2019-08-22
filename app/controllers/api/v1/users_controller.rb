# frozen_string_literal: true

class Api::V1::UsersController < ApiController
  before_action :set_user, only: %i[show]

  def index
    search_attributes = params.permit(:search, :status, :type)
    @users = User.search(search_attributes).page(params[:page]).all_except(current_user)
    json_string = UserSerializer.new(@users).serialized_json
    render json: json_string
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded user', data: @user }, status: :ok
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    return render json: { message: 'User not found' }, status: :not_found if @user.blank?
  end

  def authorize_user
    render json: { message: 'You are not authorize to perform this action' } unless current_user.admin?
  end
end
