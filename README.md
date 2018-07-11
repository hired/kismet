# Kismet [![Build Status](https://travis-ci.org/hired/kismet.svg?branch=master)](https://travis-ci.org/hired/kismet)

This gem provides a simple method of writing data to an AWS Kinesis stream.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kismet'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kismet

## Usage

To write to a Kismet stream, initialize your writer:
```ruby
writer = Kismet::Writer.new('YOUR-STREAM-NAME')
```
To write, simply call `put!`
```ruby
writer.put!('FIRE!')
```
It works with numerics as well:
```ruby
writer.put!(8675309)
```
And hashes!
```ruby
writer.put!({ structured: 'data' })
```
Set your own custom partition keys for more control:
```ruby
writer.put!('Partition me plz', 'custom-partition-key')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/kismet. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Kismet project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/kismet/blob/master/CODE_OF_CONDUCT.md).
