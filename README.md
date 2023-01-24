## Description

A simple gem that does run-length encoding.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'run_length_encoding_rb'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install run_length_encoding_rb

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

* *Array<Hash{:chunk => Object, :count => Integer}>*

    Encoded data in the following format:
    Array<Hash{:chunk => Object, :count => Integer}>, where:
    * :chunk => Object: a repeated element;
    * :count => Integer: how many times the element is repeated.

#### Encoding examples

```ruby
require 'run_length_encoding'

rle = RunLengthEncoding.new

# Encode an array:
a = %w[foo foo bar foo foo foo]

rle.encode(a)
# => [{:chunk=>"foo", :count=>2}, {:chunk=>"bar", :count=>1}, {:chunk=>"foo", :count=>3}]

# Encode a string with a default separator (each character is treated as a single element):
str = 'foo'
rle.encode(str)
# => [{:chunk=>"f", :count=>1}, {:chunk=>"o", :count=>2}]

# Encode a string with a custom separator:
str = 'foo_foo_bar'
rle.encode(str, '_')
# => [{:chunk=>"foo", :count=>2}, {:chunk=>"bar", :count=>1}]

# Encode an enumerator:
str = 'foo'
rle.encode(str.each_byte)
# => [{:chunk=>102, :count=>1}, {:chunk=>111, :count=>2}]
```

### Decoding

obj.decode(data) -> array

#### Arguments

* *data*

    Data to decode in the following format:
    Array<Hash{:chunk => Object, :count => Integer}>, where:
    * :chunk => Object: a repeated element;
    * :count => Integer: how many times the element is repeated.

#### Returns

* *Array<Object>*

    Decoded data.

#### Decoding example

```ruby
require 'run_length_encoding'

rle = RunLengthEncoding.new

# Decode data of mixed types:
data = [
  { count: 3, chunk: "foo" },
  { count: 1, chunk: "bar" },
  { count: 2, chunk: nil },
  { count: 4, chunk: 1 }
]

rle.decode(data)
# => ["foo", "foo", "foo", "bar", nil, nil, 1, 1, 1, 1]
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/8bit-mate/run_length_encoding.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
