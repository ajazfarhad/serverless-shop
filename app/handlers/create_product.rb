# frozen_string_literal: true

require 'aws-sdk-dynamodb'
require_relative '../lib/create_product_handler/create_product_handler'

module CreateProduct
  def self.handler(event:, context:)
    CreateProductHandler.new(event: event).create
    { statusCode: 200, body: 'Product was successfully created' }
  rescue Aws::DynamoDB::Errors::ServiceError => e
    { statusCode: 502, body: e.message }
  end
end
