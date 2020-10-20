# frozen_string_literal: true

require_relative '../base_handler'

class CreateProductHandler < BaseHandler
  def params
    {
      table_name: TABLE_NAME,
      item: JSON.parse(event_struct.body)
    }
  end
end
