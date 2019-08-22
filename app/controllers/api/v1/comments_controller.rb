# frozen_string_literal: true

class Api::V1::CommentsController < ApiController
  before_action :set_comment, only: %i[show]

  def index
    @comments = Comment.all
    json_string = CommentSerializer.new(@comments).serialized_json
    render json: json_string
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded Comment', data: @comment }, status: :ok
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])
    return render json: { message: 'comment not found' }, status: :not_found if @comment.blank?
  end
end
