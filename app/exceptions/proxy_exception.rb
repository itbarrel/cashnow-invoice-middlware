# frozen_string_literal: true

class ProxyException < StandardError
  attr_accessor :code

  def initialize(message = nil, code = nil)
    super(message)
    self.code = code
  end
end
