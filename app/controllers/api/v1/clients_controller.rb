# frozen_string_literal: true

class Api::V1::ClientsController < ApiController
  before_action :authorize_request, except: :create

  def index
    @clients = Client.search(params[:search])
    json_string = ClientSerializer.new(@clients).serialized_json
    render json: json_string
  end

  def show
    set_client
    render json: { status: 'SUCCESS', message: 'Loaded client', data: @client }, status: :ok
  end

  private

  def set_client
    @client = Client.find_by(id: params[:id])
    return redirect_to root_path, alert: 'client not found' if @client.blank?
  end
end
