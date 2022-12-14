# frozen_string_literal: true

require_relative "run_length_encoding/version"

#
# Provides methods to encode and decode data using RLE.
#
module RunLengthEncoding
  #
  # Encodes array of data using run-length encoding.
  #
  # @param [Array] data
  #   Data to encode.
  #
  # @return [Array<Hash{:chunk, :count}>]
  #   Encoded data, where:
  #   :chunk: a repeated element;
  #   :count: how many times an element is repeated.
  #
  # @raise [ArgumentError]
  #
  def self.encode(data)
    result = []

    raise(ArgumentError, "Array expected, but #{data.class} was given") unless data.instance_of?(Array)
    raise(ArgumentError, "the given array is empty (no data to encode)") if data.to_a.empty?

    data.each.inject([]) do |memo, element|
      if memo.last && element == memo.last.last
        memo.last[0] += 1
      else
        memo << [1, element]
      end
      result = memo
    end
    result.map { |count, chunk| { chunk: chunk, count: count } }
  end

  #
  # Decodes run-length data.
  #
  # @TODO!
  #
  def self.decode(data)
    raise(NotImplementedError, "decoding isn't implementend yet")
  end
end
