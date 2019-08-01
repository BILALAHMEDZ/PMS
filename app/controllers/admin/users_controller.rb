# frozen_string_literal: true

class Admin::UsersController < AdminBaseController
  def index
    @users = User.search(params[:search]).order(:created_at).page(params[:page]).all_except(current_user)
  end

  def new
    @user = User.new
  end

  def show
    find_user
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
    find_user
  end

  def update
    find_user
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    find_user
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully destroyed.'
  end

  private

  def find_user
    @user = User.find_by_id(params[:id])
    render file: 'public/404.html', status: :not_found, layout: false unless @user
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
