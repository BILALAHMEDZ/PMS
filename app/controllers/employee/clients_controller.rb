# frozen_string_literal: true

class Employee::ClientsController < ApplicationController
  def index
    @clients = Client.search(params[:search]).order(:id).page(params[:page])
  end

  def show
    @client = Client.find_by_id(params[:id])
    render file: 'public/404.html', status: :not_found, layout: false unless @client
  end
end
