# frozen_string_literal: true

require 'ostruct'
require 'aws-sdk-dynamodb'

# Bsse class for handler operations
class BaseHandler
  REGION = 'eu-west-2'
  TABLE_NAME = 'Products'
  AVAILABLE_ACTIONS = { show: 'get', create: 'put', delete: 'delete', update: 'update' }.freeze

  def initialize(**options)
    @event = options[:event]
  end

  def event_struct
    OpenStruct.new(event)
  end

  attr_reader :event

  def client
    @client ||= Aws::DynamoDB::Client.new(region: REGION)
  end

  def method_missing(method)
    super unless AVAILABLE_ACTIONS.keys.include?(method)
    client.send("#{AVAILABLE_ACTIONS[method]}_item", params)
  end

  def params
    {
      table_name: TABLE_NAME,
      key: {
        PK: event_struct.pathParameters.dig('pk'),
        SK: event_struct.pathParameters.dig('sk')
      }
    }
  end
end
