# frozen_string_literal: true

require_relative "constants"

#
# Encode data with RLE.
#
module Encoder
  include Constants

  #
  # Check and then pass data to the actual encoder.
  #
  # @param [Array, String, Enumerator] data
  #   Data to encode.
  #
  # @param [String, Regexp] separator ("")
  #   Separator for the string arguments.
  #
  # @return [Array<Hash{ Symbol => Object }>]
  #   Encoded data. Each element is a Hash with the following key-value pairs:
  #     [Constants::CHUNK_KEY => Object]
  #       A repeated object.
  #
  #     [Constants::COUNT_KEY => Integer]
  #       How many times the object is repeated.
  #
  # @raise [ArgumentError, TypeError]
  #   Raises if data isn't an Array/String/Enumerator [TypeError] or an empty Array [ArgumentError].
  #
  def encode(data, separator = "")
    valid_data, ex_details = _check_enc_data(data, separator)

    raise(ex_details[:ex_type], ex_details[:ex_msg]) if ex_details

    _encode(valid_data)
  end

  private

  #
  # Check if data is an array, convert to an array if possible.
  #
  # @return [Array] data
  #   Ready-to-be-encoded data.
  #
  # @return [Hash{ Symbol => Object }] ex_details
  #   Exception type and error if data can't be encoded.
  #
  def _check_enc_data(data, separator)
    ex_details = nil

    case data
    when Array
      array = data
    when String
      array = data.split(separator)
    when Enumerator
      array = data.to_a
    else
      ex_details = {
        ex_type: TypeError,
        ex_msg: "wrong argument type #{data.class} (expected Array, String or Enumerator)"
      }
    end

    if array.to_a.empty?
      ex_details = {
        ex_type: ArgumentError,
        ex_msg: "the given data is empty (no data to encode)"
      }
    end

    return array, ex_details
  end

  #
  # Encode array using run-length encoding.
  #
  # @param [Array] data
  #   Data to encode.
  #
  # @return [Array<Hash{ Symbol => Object }>]
  #   Encoded data. Each element is a Hash with the following key-value pairs:
  #     [Constants::CHUNK_KEY => Object]
  #       A repeated object.
  #
  #     [Constants::COUNT_KEY => Integer]
  #       How many times the object is repeated.
  #
  def _encode(data)
    result = []

    data.each.inject([]) do |memo, element|
      if memo.last && element == memo.last.last
        memo.last[0] += 1
      else
        memo << [1, element]
      end
      result = memo
    end
    result.map { |count, chunk| { CHUNK_KEY => chunk, COUNT_KEY => count } }
  end
end
