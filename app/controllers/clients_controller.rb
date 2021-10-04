class ClientsController < ApplicationController
    before_action :find_client,only: %i[ show edit update destroy ]
    def index
        @clients=Client.all
    end

    def show
    end

    def new
        @client = Client.new  
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

    def edit
    end
    def update
        respond_to do |format|
            if @client.update(client_params)
                format.html { redirect_to @client, notice: "client was successfully updated." }
                format.json { render :show, status: :ok, location: @client }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @client.errors, status: :unprocessable_entity }
            end
        end 
    end
    

    def destroy
        
         respond_to do |format|
            if @client.destroy
                format.html { redirect_to @client, notice: "client was successfully delete." }
                format.json { render :index, status: :delete, location: @client }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @client.errors, status: :unprocessable_entity }
            end
        end
    end

    private
    
    def find_client
        @client = Client.find(params[:id])
    end

    def client_params
        par = params.require(:client).permit(:client_code, :password, :email, :api_url, :api_method, :token)
        par[:api_method] = par[:api_method].to_i
        par
    end


end
