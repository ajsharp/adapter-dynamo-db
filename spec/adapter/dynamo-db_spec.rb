require 'spec_helper'
require 'ruby-debug'

describe Adapter::DynamoDB do
  before(:all) do
    @config = YAML.load_file('spec/fixtures/config.yml')
    AWS.config(
      :access_key_id     => @config[:access_key_id],
      :secret_access_key => @config[:secret_access_key]
    )

    @dynamo = AWS::DynamoDB.new(
      :access_key_id     => @config[:access_key_id],
      :secret_access_key => @config[:secret_access_key]
    )
    
    @table = if @dynamo.tables['test_table'].exists?
      @dynamo.tables['test_table'].tap(&:load_schema)
    else
      @dynamo.tables.create("test_table", 3, 5, {:hash_key => {:id => :string}}).tap(&:load_schema)
    end
    
  end

  after(:each) { @table.items.each { |i| i.delete }}

  before do
    @adapter = Adapter[:dynamo_db].new(@table)
    @adapter.clear
  end

  let(:adapter) { @adapter }
  let(:client)  { @table }

  it "allows writing" do
    expect {
      adapter.write("123", {"key" => "value"})
    }.to change { client.items.count }.by(1)
  end

  it "allows reading" do 
    adapter.write("123", {"name" => "Alex Sharp"})
    adapter.read('123').should == {"id" => "123", "name" => "Alex Sharp"}
  end

  it "allows deleting an item" do 
    adapter.write("123", {"name" => "Alex Sharp"})
    expect {
      adapter.delete("123")
    }.to change { client.items.count }.by(-1)
  end

  it "allows clearing all items in the table" do
    adapter.write("123", {"name" => "Alex Sharp"})
    adapter.write("234", {"name" => "John Doe"})
    expect { adapter.clear }.should change { client.items.count }.to(0)
  end
end
