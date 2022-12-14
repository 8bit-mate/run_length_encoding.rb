## Description

Provides run-length encoding and decoding.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'run_length_encoding'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install run_length_encoding

## Usage

### Encoding
```ruby
require 'run_length_encoding'

a = ['foo', 'foo', 'bar', 'foo', 'foo', 'foo']

encoded_data = RunLengthEncoding.encode(a)
# => [{:chunk=>"foo", :count=>2}, {:chunk=>"bar", :count=>1}, {:chunk=>"foo", :count=>3}]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/run_length_encoding.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
