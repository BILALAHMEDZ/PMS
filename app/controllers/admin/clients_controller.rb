# frozen_string_literal: true

class Admin::ClientsController < AdminBaseController
  def index
    @clients = Client.search(params[:search]).order(:id).page(params[:page])
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    respond_to do |format|
      if @client.save
        format.html { redirect_to admin_clients_url, notice: 'Client was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to admin_clients_path, notice: 'Client was successfully updated.' }
      else
        format.html { render :client_edit }
      end
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    respond_to do |format|
      format.html { redirect_to admin_clients_path, notice: 'Client was successfully destroyed.' }
    end
  end

  private

  def client_params
    params.require(:client).permit(:name, :phone, :email)
  end
end
