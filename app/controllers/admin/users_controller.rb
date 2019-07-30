# frozen_string_literal: true

class Admin::UsersController < AdminBaseController
  def index
    @users = User.search(params[:search]).order(:id).page(params[:page]).all_except(current_user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_url, notice: 'User was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
      else
        format.html { render :user_edit }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: 'User was successfully destroyed.' }
    end
  end

  private

  def create_params
    params.require(:user).permit(:name, :status, :type, :email, :password)
  end

  def user_params
    params.require(klass.to_s.underscore).permit(:name, :status, :type, :email)
  end

  def klass
    @user.class
  end
end
