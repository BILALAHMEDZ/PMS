# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @projects = Project.order(:amount)
  end

  def profile_edit
    find_user
  end

  def profile_update
    find_user
    if @user.update(user_params)
      redirect_to edit_profile_path, notice: 'User was successfully updated.'
    else
      render :profile_edit
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
    return redirect_to root_path, alert: 'User not found' if @user.blank?
  end

  def user_params
    params.require(klass.to_s.underscore).permit(:name, :email, :image)
  end

  def klass
    @user.class
  end
end
