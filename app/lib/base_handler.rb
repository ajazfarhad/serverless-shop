# frozen_string_literal: true

require 'ostruct'
require 'aws-sdk-dynamodb'

# Bsse class for handler operations
class BaseHandler
  REGION = 'eu-west-2'
  TABLE_NAME = 'Products'

  def initialize(**options)
    @event = options[:event]
    @action = options[:action]
  end

  def call
    call_action(action)
  end

  def event_struct
    OpenStruct.new(event)
  end

  attr_reader :event, :action

  def client
    @client ||= Aws::DynamoDB::Client.new(region: REGION)
  end

  def get_item
    client.get_item(params)
  end

  def create_item
    client.put_item(params)
  end

  def delete_item
    client.delete_item(params)
  end

  def update_item
    client.update_item(params)
  end

  def call_action(action)
    case action
    when :show
      get_item
    when :create
      create_item
    when :update
      update_item
    when :delete
      delete_item
    end
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
