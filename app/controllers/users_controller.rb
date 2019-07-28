# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def users_list
    @users = User.all_except(current_user)
  end

  def user_edit
    find_user
  end

  def profile_edit
    find_user
  end

  def profile_update
    find_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to userslist_path, notice: 'User was successfully updated.' }
      else
        format.html { render :profile_edit }
      end
    end
  end

  def user_update
    find_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to userslist_path, notice: 'User was successfully updated.' }
      else
        format.html { render :user_edit }
      end
    end
  end

  def destroy_user
   find_user
   @user.destroy
   respond_to do |format|
     format.html { redirect_to userslist_path, notice: 'User was successfully destroyed.' }
   end
  end

  private

  def user_params
    params.require(klass.to_s.underscore).permit(:name, :status, :type, :email)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def klass
    @user.class
  end
end
