# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[edit update show destroy]

  def index
    @clients = Client.clients_by(current_user)
  end

  def show; end

  def new
    @client = Client.new
  end

  def edit; end

  def create
    @client = Client.new(client_params)
    @client.user_id = current_user.id

    if @client.save
      redirect_to @client, notice: 'Client was succesfully created'
    else
      render :new
    end
  end

  def update
    if @client.update(client_params)
      redirect_to @client, notice: 'Client was successfully edited'
    else
      render :edit
    end
  end

  def destroy
    @client.delete

    redirect_to clients_path, notice: 'Client succesfully deleted'
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :address, :obs)
  end
end
