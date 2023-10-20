# frozen_string_literal: true

require_relative "test_helper"
require_relative "random_data_mixin"

class TestRunLengthEncodingRb < Minitest::Test
  include RandomDataMixin

  def test_that_it_has_a_version_number
    refute_nil ::RunLengthEncodingRb::VERSION
  end

  #
  # Encode an array, then decode it back.
  # The original and the result arrays should
  # match.
  #
  def test_encode_decode_an_array
    original_arr = _generate_random_array
    result_arr = RunLengthEncodingRb.decode(
      RunLengthEncodingRb.encode(original_arr)
    )

    assert_equal original_arr, result_arr
  end

  #
  # Encode a string, then decode it back.
  # The original and the result strings should
  # match.
  #
  def test_encode_decode_a_string_with_the_separator
    separator = ","
    original_str = _generate_random_string(separator: separator)
    result_arr = RunLengthEncodingRb.decode(
      RunLengthEncodingRb.encode(original_str, separator)
    )

    assert_equal original_str, result_arr.join(separator)
  end
end
