# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  def index
    @comments = Comment.page(params[:page])
  end

  def new
    @comment = Comment.new
  end

  def show; end

  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    @comment.assign_attributes(comment_params)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])
    return redirect_to root_path, alert: 'Comment not found' if @comment.blank?
  end

  def comment_params
    params.require(:comment).permit(:message, :commentable_id, :commentable_type, :creater_id)
  end
end
