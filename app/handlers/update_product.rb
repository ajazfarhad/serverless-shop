# frozen_string_literal: true

require 'aws-sdk-dynamodb'
require_relative '../lib/update_product_handler/update_product_handler'

module UpdateProduct
  def self.handler(event:, context:)
    UpdateProductHandler.new(event: event, action: :update).call
    { statusCode: 200, body: 'Product was successfully updated' }
  rescue Aws::DynamoDB::Errors::ServiceError => e
    { statusCode: 502, body: e.message }
  end
end
