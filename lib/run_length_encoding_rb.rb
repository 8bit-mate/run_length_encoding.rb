# frozen_string_literal: true

require_relative "run_length_encoding_rb/decoder"
require_relative "run_length_encoding_rb/encoder"
require_relative "run_length_encoding_rb/error"
require_relative "run_length_encoding_rb/error/attr_inaccessible_error"
require_relative "run_length_encoding_rb/error/attr_missing_error"
require_relative "run_length_encoding_rb/error/negative_int_error"
require_relative "run_length_encoding_rb/error/type_error"
require_relative "run_length_encoding_rb/rle_element"
require_relative "run_length_encoding_rb/version"

#
# Run-length encoding/decoding.
#
module RunLengthEncodingRb
  #
  # Encode data.
  #
  # @param [Array, String, Enumerator] data
  #   Data to encode.
  #
  # @option [String, Regexp] separator ("")
  #   Separator for the String-typed data.
  #
  # @return [Array<::RLEElement>]
  #   Encoded data.
  #
  def self.encode(data, separator = "")
    encoder = Encoder.new
    encoder.encode(data, separator)
  end

  #
  # Decode data.
  #
  # @param [Array<::RLEElement, #chunk, #run_length>] data
  #   Data to decode.
  #
  # @return [Array<Object>]
  #   Decoded data.
  #
  def self.decode(data)
    decoder = Decoder.new
    decoder.decode(data)
  end
end
