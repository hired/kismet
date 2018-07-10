require 'spec_helper'
require 'aws-sdk-kinesis'

class MockAwsResponse
  def initialize(success = true)
    @success = success
  end

  def sequence_number
    return '1' if @success
    nil
  end
end

describe Kismet::Writer do
  subject { described_class.new('raw_events_stream_test', region: 'us-east-1') }

  it 'can be initialized successfully' do
    expect(subject).to be_instance_of(Kismet::Writer)
  end

  it 'can write a hash to a stream' do
    mock_response = MockAwsResponse.new(true)
    expect_any_instance_of(Aws::Kinesis::Client).to receive(:put_record)
      .and_return(mock_response)

    result = subject.put!(test: 'success!')
    expect(result).to eq('1')
  end

  it 'can write a number to a stream' do
    mock_response = MockAwsResponse.new(true)
    expect_any_instance_of(Aws::Kinesis::Client).to receive(:put_record)
      .and_return(mock_response)

    result = subject.put!(1)
    expect(result).to eq('1')
  end

  it 'can write to a stream with a custom partition key' do
    mock_response = MockAwsResponse.new(true)
    expect_any_instance_of(Aws::Kinesis::Client).to receive(:put_record)
      .and_return(mock_response)

    result = subject.put!('fire!', 'custom_partition_key')
    expect(result).to eq('1')
  end
end
