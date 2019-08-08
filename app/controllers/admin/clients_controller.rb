# frozen_string_literal: true

class Admin::ClientsController < AdminBaseController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  def index
    @clients = Client.search(params[:search]).page(params[:page])
  end

  def new
    @client = Client.new
  end

  def show
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to admin_clients_url, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @client.update(client_params)
      redirect_to admin_clients_path, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @client.destroy
    redirect_to admin_clients_path, notice: 'Client was successfully destroyed.'
  end

  private

  def set_client
    @client = Client.find_by(id: params[:id])
    return redirect_to root_path, alert: 'client not found' if @client.blank?
  end

  def client_params
    params.require(:client).permit(:name, :phone, :email)
  end
end
