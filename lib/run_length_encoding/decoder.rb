# frozen_string_literal: true

require_relative "decoding_element_check"
require_relative "constants"

#
# Decode run-length encoded data.
#
module Decoder
  include Constants
  include DecodingElementCheck

  #
  # Pass data to the decoder.
  #
  # @param [Array<Hash{ Symbol => Object }>] data
  #
  # @return [Array]
  #
  # @raise [ArgumentError, TypeError]
  #   Raises if data isn't an Array [TypeError] or an empty Array [ArgumentError].
  #
  def decode(data)
    ex_details = _check_dec_data(data)

    raise(ex_details[:ex_type], ex_details[:ex_msg]) if ex_details

    _decode(data)
  end

  private

  def _check_dec_data(data)
    case data
    when Array
      if data.to_a.empty?
        {
          ex_type: ArgumentError,
          ex_msg: "the given data is empty (no data to decode)"
        }
      end
    else
      {
        ex_type: TypeError,
        ex_msg: "wrong argument type #{data.class} (expected Array)"
      }
    end
  end

  #
  # Decode data.
  #
  # @param [Array<Hash{ Symbol => Object }>] data
  #
  # @return [Array]
  #
  # @raise [ArgumentError, TypeError]
  #
  def _decode(data)
    decoded_data = []

    data.each do |hash|
      check_result = _valid_hash?(hash)
      raise(check_result[:ex_type], check_result[:ex_msg]) unless check_result[:comply]

      hash[COUNT_KEY].times { decoded_data.append(hash[CHUNK_KEY]) }
    end

    decoded_data
  end
end
