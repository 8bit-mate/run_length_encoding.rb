## Description

A simple gem that does run-length encoding.

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

obj.encode(data [, separator]) -> array

#### Arguments

* *data*
    Data to encode. Supported types:
    * Array;
    * String;
    * Enumerator.

* *separator*
    A String or Regexp to split the string into single elements. Used only if *data* is a String.

#### Returns

* *[Array<Hash{:chunk, :count}>]*
    Encoded data, where:
    * :chunk: a repeated element;
    * :count: how many times the element is repeated.

#### Examples

```ruby
require 'run_length_encoding'

rle = RunLengthEncoding.new

# Encoding an array:
a = ['foo', 'foo', 'bar', 'foo', 'foo', 'foo']

rle.encode(a)
# => [{:chunk=>"foo", :count=>2}, {:chunk=>"bar", :count=>1}, {:chunk=>"foo", :count=>3}]

# Encoding a string with a default separator (each character is treated as a single element):
srt = 'foo"
rle.encode(str)
# => [{:chunk=>"f", :count=>1}, {:chunk=>"o", :count=>2}]

# Encoding a string with a custom separator:
str = 'foo_foo_bar"
rle.encode(str, '_')
# => [{:chunk=>"foo", :count=>2}, {:chunk=>"bar", :count=>1}]

# Encoding an enumerator:
str  = 'foo'
rle.encode(str.each_byte)
# => [{:chunk=>102, :count=>1}, {:chunk=>111, :count=>2}]
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/8bit-mate/run_length_encoding.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
