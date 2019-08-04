# frozen_string_literal: true

class CommentsBaseController < ApplicationController
  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def show
    find_comment
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to my_comment, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def edit
    find_comment
  end

  def update
    find_comment
    if @comment.update(comment_params)
      redirect_to my_comment, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    find_comment
    @comment.destroy
    redirect_to my_comment, notice: 'Comment was successfully destroyed.'
  end

  private

  def find_comment
    @comment = Comment.find_by_id(params[:id])
    render file: 'public/404.html', status: :not_found, layout: false unless @comment
  end

  def comment_params
    params.require(:comment).permit(:message)
  end
end
