# frozen_string_literal: true

class Api::V1::ClientsController < ApiController
  before_action :set_client, only: %i[show]

  def index
    @clients = Client.search(params[:search]).page(params[:page])
    json_string = ClientSerializer.new(@clients).serialized_json
    render json: json_string
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded client', data: @client }, status: :ok
  end

  private

  def set_client
    @client = Client.find_by(id: params[:id])
    return render json: { message: 'Client not found' }, status: :not_found if @client.blank?
  end
end
