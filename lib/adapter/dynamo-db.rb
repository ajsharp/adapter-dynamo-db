require 'aws-sdk'
require 'aws/dynamo_db'
require 'adapter'

module Adapter
  module DynamoDB

    # Read an item from the table
    def read(key)
      items[key].attributes.to_h
    end

    # Write a new item to the table
    def write(key, value)
      items.create(value.merge(:id => key))
    end

    # Delete an item from the table
    def delete(key)
      items[key].delete
    end

    # Clear all items from the table
    def clear
      items.each { |i| i.delete }
    end

    # def encode(value)
    # end
    # 
    # def decode(value)
    # end

    private
    def items
      client.items
    end
  end
end

Adapter.define(:dynamo_db, Adapter::DynamoDB)