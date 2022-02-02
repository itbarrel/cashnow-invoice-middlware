class DocumentService
   def initialize()
      @model = Document
      
   end
   def all(query = {})
      @records = @model.ransack(query)
      @records.result(distinct: false)
   end
end