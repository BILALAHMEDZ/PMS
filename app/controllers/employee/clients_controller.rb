# frozen_string_literal: true

class Employee::ClientsController < EmployeeBaseController
  def index
    @clients = Client.search(params[:search]).page(params[:page])
  end

  def show
    @client = Client.find_by(id: params[:id])
    return redirect_to root_path, alert: 'client not found' if @client.blank?
  end
end
