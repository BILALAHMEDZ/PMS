# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

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
    @user = User.find_by_id(params[:id])
    render file: 'public/404.html', status: :not_found, layout: false unless @user
  end

  def user_params
    params.require(klass.to_s.underscore).permit(:name, :email, :image)
  end

  def klass
    @user.class
  end
end
