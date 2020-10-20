# frozen_string_literal: true

require 'aws-sdk-dynamodb'
require_relative '../lib/delete_product_handler/delete_product_handler'

module DeleteProduct
  def self.handler(event:, context:)
    DeleteProductHandler.new(event: event, action: :delete).call
    { statusCode: 200, body: 'Product was successfully deleted' }
  rescue Aws::DynamoDB::Errors::ServiceError => e
    { statusCode: 502, body: e.message }
  end
end
