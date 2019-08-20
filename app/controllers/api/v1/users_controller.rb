# frozen_string_literal: true

class Api::V1::UsersController < ApiController
  before_action :authorize_request, except: :create
  before_action :authorize_user, only: %i[index show]

  def index
    @users = User.search(params[:search])
    json_string = UserSerializer.new(@users).serialized_json
    render json: json_string
  end

  def show
    set_user
    render json: { status: 'SUCCESS', message: 'Loaded user', data: @user }, status: :ok
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    return redirect_to root_path, alert: 'User not found' if @user.blank?
  end

  def authorize_user
    render json: { message: 'You are not authorize to perform this action' } unless current_user.admin?
  end
end
