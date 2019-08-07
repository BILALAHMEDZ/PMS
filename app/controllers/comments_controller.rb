# frozen_string_literal: true

class CommentsController < ApplicationController
  def index
    @comments = Comment.order(:id).page(params[:page])
  end

  def new
    @comment = Comment.new
  end

  def show
    set_comment
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.commentable_id=params[:commentable_id]
    @comment.commentable_type=params[:commentable_type]
    @comment.creater_id = current_user.id
    if @comment.save
      redirect_to request.referrer, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  def edit
    set_comment
  end

  def update
    set_comment
    if @comment.update(comment_params)
      redirect_to request.referrer, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    set_comment
    @comment.destroy
      redirect_to request.referrer, notice: 'Client was successfully destroyed.'
  end

  private

  def set_comment
    @comment = Comment.find_by_id(params[:id])
    render file: 'public/404.html', status: :not_found, layout: false unless @comment
  end

  def comment_params
    params.require(:comment).permit(:message)
  end
end
