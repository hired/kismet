require 'aws-sdk-kinesis'
require 'date'
require 'json'

module Kismet
  class Writer

    # Initializes a Kismet::Writer given a stream name. By default,
    # this pulls the AWS credentials stored in the environment.
    # Optionally accepts an array of options:
    # - region: Specify the AWS region the stream is located within.
    def initialize(stream, options = {})
      @stream = stream
      region = options[:region] || nil

      begin
        client_options = {}
        client_options[:region] = region if region
        @client = Aws::Kinesis::Client.new(client_options)
      rescue Aws::Kinesis::Errors::ServiceError
        @client = nil
      end
    end

    # Writes data to the stream initialized in the AWS::Kinesis::Client.
    # Optionally accepts a partition_key parameter to allow for manual
    # partitioning / management of shards.
    #
    # Returns a hash on success, otherwise nil
    def put!(data, partition_key = nil)
      # If the client isn't valid, don't go through with the request.
      return false unless @client

      # Ensure the partition_key has a sensible default if omitted.
      partition_key ||= Time.now.to_s

      # Transform the data into a string.
      data = data.to_json if data.is_a?(Hash)
      data = data.to_s if data.is_a?(Numeric)

      response = nil
      begin
        request = @client.put_record(
          stream_name: @stream,
          data: data,
          partition_key: partition_key
        )
        response = {
          shard_id: request.shard_id,
          sequence_number: request.sequence_number,
          encryption_type: request.encryption_type
        }
      rescue Aws::Kinesis::Errors::ServiceError
        response = nil
      end

      response
    end

  end
end
