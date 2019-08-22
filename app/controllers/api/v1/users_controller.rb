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

  def update
    @user = current_user
    if @user.update(user_params)
      render json: { status: 'SUCCESS', message: 'Updated User', data: @user }, status: :ok
    else
      render json: { status: 'ERROR', message: 'User not updated', data: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image)
  end

  def set_user
    @user = User.find_by(id: params[:id])
    return render json: { message: 'User not found' }, status: :not_found if @user.blank?
  end

  def klass
    @user.class
  end

  def authorize_user
    render json: { message: 'You are not authorize to perform this action' } unless current_user.admin?
  end
end
