class ClientService
    def initialize()
        @model = Client
        
    end
    
    def all(query = {})
        @records = @model.ransack(query)
        @records.result(distinct: true)
    end

    def vendors(client_id, query = {})
        @records = @model.find(client_id).vendors.ransack(query)
        @records.result(distinct: true)
    end
end