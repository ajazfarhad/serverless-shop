# frozen_string_literal: true

require_relative '../base_handler'

class UpdateProductHandler < BaseHandler
  def params
    super.merge({
                  expression_attribute_names: attribute_names(event_struct),
                  update_expression: update_expression(attribute_names(event_struct), attribute_values(event_struct)),
                  expression_attribute_values: attribute_values(event_struct)
                })
  end

  def attribute_names(data)
    parsed_data = JSON.parse(data.body)
    parsed_data.keys.each_with_object({}) { |key, hash| hash["##{key[0].upcase}"] = key }
  end

  def attribute_values(data)
    parsed_data = JSON.parse(data.body)
    parsed_data.each_with_object({}) { |(key, val), hash| hash[":#{key[0].downcase}"] = val }
  end

  def update_expression(names, values)
    zipped = names.keys.zip(values.keys)
    expression = zipped.map do |item|
      item.join(' = ')
    end.join(' , ')
    "SET #{expression}"
  end
end
