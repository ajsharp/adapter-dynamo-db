## adapter-dynamo-db

This is an adapter for Amazon's DynamoDB for the [adapter gem](https://github.com/newtoy/adapter/).
It's currently just a prototype.

## Usage

```ruby
$dynamo = AWS::DynamoDB.new(
  :access_key_id => "secret_key_id",
  :secret_access_key => "secret_access_key"
)

# The DynamoDB table needs to have been created already.
# Don't forget to invoke load_schema on the table before using it!
Adapter[:dynamo_db].new($dynamo.tables['my_table'].tap(&:load_schema))
```

## Requirements

* https://github.com/newtoy/adapter/
* https://github.com/amazonwebservices/aws-sdk-for-ruby