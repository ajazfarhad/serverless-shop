# frozen_string_literal: true

require 'json'
require 'aws-sdk-dynamodb'
require_relative '../lib/show_product_handler/show_product_handler'

module ShowProduct
  def self.handler(event:, context:)
    result = ShowProductHandler.new(event: event).show
    { statusCode: 200, body: JSON.generate(result.item) }
  rescue Aws::DynamoDB::Errors::ServiceError => e
    { statusCode: 502, body: e.message }
  end
end
