# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def users_list
    @users = User.all_except(current_user)
  end

  def user_edit
    @user = User.find(params[:id])
  end

  def user_update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to userslist_path, notice: 'User was successfully updated.' }
      else
        format.html { render :user_edit }
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
