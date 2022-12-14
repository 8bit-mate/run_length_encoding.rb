# frozen_string_literal: true

#
# Set of methods to encode data.
#
module Encoder
  #
  # Prepares and validates data for the encoding, when sends data for encoding.
  #
  # @param [Array, String, Enumerator] data
  #   Data to encode.
  #
  # @param [String, Regexp] separator ("")
  #   Separator for the string arguments.
  #
  # @return [Array<Hash{:chunk, :count}>]
  #   Encoded data, where:
  #   :chunk: a repeated element;
  #   :count: how many times the element is repeated.
  #
  # @raise [ArgumentError, TypeError]
  #
  def encode(data, separator = "")
    case data
    when Array
      raise(ArgumentError, "the given array is empty (no data to encode)") if data.to_a.empty?

      _encode(data)
    when String
      _encode(data.split(separator))
    when Enumerator
      _encode(data.to_a)
    else
      raise(TypeError, "wrong argument type #{data.class} (expected Array, String or Enumerator) ")
    end
  end

  private

  #
  # Encodes array using run-length encoding.
  #
  # @param [Array] data
  #   Data to encode.
  #
  # @return [Array<Hash{:chunk, :count}>]
  #   Encoded data, where:
  #   :chunk: a repeated element;
  #   :count: how many times an element is repeated.
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
    result.map { |count, chunk| { chunk: chunk, count: count } }
  end
end
