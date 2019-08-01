# frozen_string_literal: true

class Admin::ClientsController < AdminBaseController
  def index
    @clients = Client.search(params[:search]).order(:id).page(params[:page])
  end

  def new
    @client = Client.new
  end

  def show
    find_user
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
    find_user
  end

  def update
    find_user
    if @client.update(client_params)
      redirect_to admin_clients_path, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    find_user
    @client.destroy
    redirect_to admin_clients_path, notice: 'Client was successfully destroyed.'
  end

  private

  def find_user
    @client = Client.find_by_id(params[:id])
    render file: 'public/404.html', status: :not_found, layout: false unless @client
  end

  def client_params
    params.require(:client).permit(:name, :phone, :email)
  end
end
