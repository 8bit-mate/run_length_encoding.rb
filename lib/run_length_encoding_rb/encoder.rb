# frozen_string_literal: true

module RunLengthEncodingRb
  #
  # Encode data with RLE.
  #
  class Encoder
    #
    # Encode an array with the run-length encoding.
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
    def encode(data, separator = "")
      array = _to_array(data, separator)

      _raise_on_unsupported_type(data.class) unless array

      _encode(array)
    end

    private

    #
    # @param [Array] data
    #   Data to encode.
    #
    # @return [Array<::RLEElement>]
    #   Encoded data.
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
      result.map { |run_length, chunk| RLEElement.new(chunk: chunk, run_length: run_length) }
    end

    #
    # Raise an error to notify that input data isn't an array
    # and can't be converted to an array.
    #
    # @param [Class] klass
    #
    # @raise [::TypeError]
    #
    def _raise_on_unsupported_type(klass)
      raise(
        RunLengthEncodingRb::TypeError,
        "wrong argument type #{klass} (expected Array, String or Enumerator)"
      )
    end

    #
    # Return an array representation of an input data.
    #
    # @param [Object] data
    #
    # @option [String, Regexp]
    #
    # @return [Array, nil] data
    #   nil indicates that input data cannot be converted to an array.
    #
    def _to_array(data, separator)
      case data
      when Array
        return data
      when String
        return data.split(separator)
      when Enumerator
        return data.to_a
      end

      nil
    end
  end
end
