# frozen_string_literal: true

class Employee::ClientsController < ApplicationController
  def index
    @clients = Client.search(params[:search]).order(:id).page(params[:page])
  end
end
