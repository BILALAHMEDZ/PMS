# frozen_string_literal: true

class Manager::ClientsController < ManagerBaseController
  def index
    @clients = Client.search(params[:search]).order(:id).page(params[:page])
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to manager_clients_url, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      redirect_to manager_clients_path, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to manager_clients_path, notice: 'Client was successfully destroyed.'
  end

  private

  def client_params
    params.require(:client).permit(:name, :phone, :email)
  end
end
