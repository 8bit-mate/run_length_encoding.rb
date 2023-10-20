# frozen_string_literal: true

require_relative "decoder_mixin"

module RunLengthEncodingRb
  #
  # Decode run-length encoded data.
  #
  class Decoder
    include DecoderMixin

    #
    # Decode data.
    #
    # @param [Array<::RLEElement, #chunk, #run_length>] data
    #   Data to decode.
    #
    # @return [Array<Object>]
    #   Decoded data.
    #
    def decode(data)
      _raise_on_unsupported_type(data.class) unless data.is_a?(Array)

      _decode(data)
    end

    private

    #
    # @param [Array<::RLEElement, #chunk, #run_length>] data
    #
    # @return [Array]
    #
    def _decode(data)
      decoded_data = []

      data.each do |e|
        # @todo: catch and try to fix an exception,
        # e.g.: ignore the element, etc.
        _inspect_element(e)

        e.run_length.times { decoded_data.append(e.chunk) }
      end

      decoded_data
    end

    #
    # Raise an error to notify that data isn't an array.
    #
    # @param [Class] klass
    #
    # @raise [::TypeError]
    #
    def _raise_on_unsupported_type(klass)
      raise(
        RunLengthEncodingRb::TypeError,
        "wrong argument type #{klass} (expected Array)"
      )
    end
  end
end
