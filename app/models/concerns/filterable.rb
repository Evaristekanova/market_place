module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(params = {})
      results = where(nil)
      params.each do |key, value|
        results = results.public_send(key, value) if value.present?
      end
      results.order(created_at: :desc)
    end
  end
    
end
