# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :find_client, only: %i[show edit update destroy fetch_token fetch_ftp]

  def index
    @clients = ClientService.new.all
  end

  def show; end

  def new
    @client = Client.new
    @client.login_api = @client.build_login_api
  end

  def create
    @client = Client.new(client_params)
    respond_to do |format|
      if @client.save
        format.html { redirect_to clients_url, notice: 'Client was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to clients_url, notice: 'client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @client.destroy
    #  respond_to do |format|
    #     if
    #         format.html { redirect_to @client, notice: "client was successfully delete." }
    #         format.json { render :index, status: :delete, location: @client }
    #     else
    #         format.html { render :edit, status: :unprocessable_entity }
    #         format.json { render json: @client.errors, status: :unprocessable_entity }
    #     end
    # end
  end

  def fetch_token
    ClientApiProxyWorker.perform_async(@client.id)
    flash[:notice] = 'Api authentication started.'
    redirect_to clients_path
    # message says your request is being processed
  end

  def fetch_ftp
    FtpClientWorker.perform_async(@client.id)
    flash[:notice] = 'FTP Server Start'
    redirect_to clients_path
    # message says your request is being processed
  end

  private

  def find_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:name, :company_name, :username, :password, :token, :ftp_host, :ftp_port,
                                   :ftp_user, :ftp_password, :notify_email,
                                   login_api_attributes: %i[id api_type api_method api_url client_id document_type])
    # par[:login_api_attributes][:api_type] = par[:login_api_attributes][:api_type].to_i
    # par[:login_api_attributes][:api_method] = par[:login_api_attributes][:api_method].to_i
    # par
  end
end
