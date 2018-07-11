require 'spec_helper'
require 'aws-sdk-kinesis'

class MockAwsResponse
  def initialize(success = true)
    @success = success
  end

  def shard_id
    return '1' if @success
    nil
  end

  def sequence_number
    return '123456789' if @success
    nil
  end

  def encryption_type
    return 'NONE' if @success
    nil
  end
end

describe Kismet::Writer do
  subject { described_class.new('raw_events_stream_test', region: 'us-east-1') }
  let(:mock_response) { MockAwsResponse.new(true) }

  before(:each) do
    allow_any_instance_of(Aws::Kinesis::Client).to receive(:put_record)
      .and_return(mock_response)
  end

  it 'can be initialized successfully' do
    expect(subject).to be_instance_of(Kismet::Writer)
  end

  context 'writing to a stream' do
    let(:valid_result) do
      {
        shard_id: '1',
        sequence_number: '123456789',
        encryption_type: 'NONE'
      }
    end

    it 'can write a hash' do
      result = subject.put!(test: 'success!')
      expect(result).to eq(valid_result)
    end

    it 'can write a number' do
      result = subject.put!(1)
      expect(result).to eq(valid_result)
    end

    it 'can write with a custom partition key' do
      result = subject.put!('fire!', 'custom_partition_key')
      expect(result).to eq(valid_result)
    end
  end
end
