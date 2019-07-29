# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def profile_edit
    @user = User.find(params[:id])
  end

  def profile_update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        if current_user.type == 'Admin'
          format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
        elsif current_user.type == 'User'
          format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        elsif current_user.type == 'User'
          format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        end
      else
        format.html { render :profile_edit }
      end
    end
  end

  private

  def user_params
    params.require(klass.to_s.underscore).permit(:name, :status, :type, :email)
  end

  def klass
    @user.class
  end
end
