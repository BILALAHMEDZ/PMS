# frozen_string_literal: true

class Api::V1::CommentsController < ApiController
  before_action :authorize_request, except: :create

  def index
    @comments = Comment.all
    json_string = CommentSerializer.new(@comments).serialized_json
    render json: json_string
  end

  def show
    set_comment
    render json: { status: 'SUCCESS', message: 'Loaded Comment', data: @comment }, status: :ok
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])
    return redirect_to root_path, alert: 'Comment not found' if @comment.blank?
  end
end
