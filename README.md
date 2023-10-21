# run_length_encoding_rb [![Gem Version](https://badge.fury.io/rb/run_length_encoding_rb.svg)](https://badge.fury.io/rb/run_length_encoding_rb)

## Description

Run-length encoding for Ruby.

## Installation

Add this line to your application"s Gemfile:

```ruby
gem "run_length_encoding_rb"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install run_length_encoding_rb

## Usage

### Encoding

RunLengthEncodingRb.encode(data [, separator]) -> array

#### Arguments

+ _data_

    Data to encode. Supported types:
    - Array;
    - String;
    - Enumerator.

+ _separator_

    A String or Regexp to split the _data_ string into single elements. Used only if _data_ is a String.

#### Returns

+ _Array\<RunLengthEncodingRb::RLEElement\>_

    Encoded data. Each element is a RunLengthEncodingRb::RLEElement object with the attributes #chunk (the repeated element) and #run_length (how many times the element is repeated).

### Encoding examples

```ruby
require "run_length_encoding_rb"

RLE = RunLengthEncodingRb

# Encode an array:
a = %w[foo foo bar foo foo foo]
RLE.encode(a)

# Encode a string with a default separator (each character 
# will be treated as a single element):
str = "foo"
RLE.encode(str)

# Encode a string with a explicit separator:
str = "foo_foo_bar"
RLE.encode(str, "_")

# Encode an enumerator:
str = "foo"
RLE.encode(str.each_byte)
```

### Decoding

obj.decode(data) -> array

#### Arguments

+ _data_

    Array of RunLengthEncodingRb::RLEElement (or any duck-typed objects, which have the obj#chunk and obj#run_length attributes).

#### Returns

+ Array\<Object\>

    Decoded data.

### Decoding example

```ruby
require "run_length_encoding_rb"

RLE = RunLengthEncodingRb

data = [
  RunLengthEncodingRb::RLEElement.new(chunk: "foo", run_length: 3),
  RunLengthEncodingRb::RLEElement.new(chunk: "bar", run_length: 1),
  RunLengthEncodingRb::RLEElement.new(chunk: nil, run_length: 2),
]

RLE.decode(data)
# => ["foo", "foo", "foo", "bar", nil, nil]
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/8bit-mate/run_length_encoding.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
