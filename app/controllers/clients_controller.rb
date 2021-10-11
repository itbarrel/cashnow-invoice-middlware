class ClientsController < ApplicationController
    before_action :find_client,only: %i[ show edit update destroy ]

    def index
        @clients=Client.all
    end

    def show
    end

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

    # def find_api
    #     @api = @client.api.find(params[:id])
    # end

    def client_params
        par = params.require(:client).permit(:name , :company_name, :username, :password, :token,
            login_api_attributes: [ :id, :api_type, :api_method, :api_url ]
        )
        par[:login_api_attributes][:api_type] = par[:login_api_attributes][:api_type].to_i
        par[:login_api_attributes][:api_method] = par[:login_api_attributes][:api_method].to_i
        par
    end


end
