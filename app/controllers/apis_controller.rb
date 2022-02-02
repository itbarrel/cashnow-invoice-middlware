class ApisController < ApplicationController
  before_action :find_client
  before_action :find_api, only: %i[ show edit update destroy schedule ]
  
  def new
    @api = @client.apis.build
  end

  def create
    @api = @client.apis.build(api_params)
    respond_to do |format|   
      if @api.save   
        format.html { redirect_to clients_url, notice: 'api was successfully created.' }   
        format.json { render :show, status: :created, location: @api }   
      else   
        format.html { render :new }   
        format.json { render json: @api.errors, status: :unprocessable_entity } 
      end
    end
  end

  def update
     respond_to do |format|
      if @api.update(api_params)
        format.html { redirect_to clients_path, notice: "api was successfully updated." }
        format.json { render :show, status: :ok, location: @api }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @api.errors, status: :unprocessable_entity }
      end
    end 
  end

  def edit
  end

  def destroy
  end

  private

  def find_api
    @api = Api.find_by(id: params[:id], client: @client)
  end

  def find_client
    @client = Client.find(params[:client_id]) if params[:client_id].present?
  end

  def api_params
    params.require(:api).permit(:api_type, :api_method, :api_url , :document_type)
  end
  
end
