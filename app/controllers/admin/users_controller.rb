# frozen_string_literal: true

class Admin::UsersController < AdminBaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.search(params[:search]).page(params[:page]).all_except(current_user)
  end

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(create_params)
    if @user.save
      UserMailer.with(user: @user).welcome_email.deliver
      redirect_to admin_users_url, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    return redirect_to root_path, alert: 'user not found' if @user.blank?
  end

  def create_params
    params.require(:user).permit(:name, :email, :password)
  end

  def user_params
    params.require(klass.to_s.underscore).permit(:name, :status, :type, :email)
  end

  def klass
    @user.class
  end
end
