# frozen_string_literal: true

class VendorService
  def initialize
    @model = Vendor
  end

  def all(query = {})
    @records = @model.ransack(query)
    @records.result(distinct: true)
  end
end
