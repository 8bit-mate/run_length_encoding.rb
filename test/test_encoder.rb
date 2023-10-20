# frozen_string_literal: true

require_relative "test_helper"
require_relative "random_data_mixin"

#
# Test the RunLengthEncodingRb::Encoder class.
#
class TestEncoder < Minitest::Test
  include RandomDataMixin

  def test_raises_type_error_when_unsupported_input_data_type
    assert_raises RunLengthEncodingRb::TypeError do
      input_data = 0 # Expected Array, String or Enumerator, but got Integer.
      RunLengthEncodingRb.encode(input_data)
    end
  end

  def test_return_array_when_supported_input_data_type
    input_data = []
    assert_instance_of Array, RunLengthEncodingRb.encode(input_data)
  end

  def test_return_empty_array_when_input_data_is_an_empty_array
    input_data = []
    assert_empty RunLengthEncodingRb.encode(input_data)
  end

  def test_return_empty_array_when_input_data_is_an_empty_string
    input_data = ""
    assert_empty RunLengthEncodingRb.encode(input_data)
  end

  def test_return_empty_array_when_input_data_is_an_empty_enumerator
    input_data = [].each
    assert_empty RunLengthEncodingRb.encode(input_data)
  end

  def test_return_not_empty_array_when_input_data_is_not_an_empty_array
    refute_empty RunLengthEncodingRb.encode(_generate_random_array)
  end

  def test_return_not_empty_array_when_input_data_is_not_an_empty_string
    refute_empty RunLengthEncodingRb.encode(_generate_random_string)
  end

  def test_return_not_empty_array_when_input_data_is_not_an_empty_enumerator
    input_data = _generate_random_string.each_byte
    refute_empty RunLengthEncodingRb.encode(input_data)
  end

  def test_return_empty_array_when_input_data_is_a_string_with_only_separator
    input_data = "*"
    separator = "*"
    assert_empty RunLengthEncodingRb.encode(input_data, separator)
  end

  def test_all_elements_of_result_array_are_rle_element
    assert(RunLengthEncodingRb.encode(_generate_random_array).all? do |e|
      e.is_a?(RunLengthEncodingRb::RLEElement)
    end)
  end

  def test_split_input_string_with_a_default_separator
    #
    # In the RunLengthEncodingRb#encode call a separator
    # wasn't provided explicitly, so the default one ("")
    # will be used.
    #
    separator = ""
    input_data = "abc|def|ghi"

    assert_equal(
      input_data.split(separator).length, RunLengthEncodingRb.encode(
        input_data
      ).length
    )
  end

  def test_split_input_string_with_a_custom_separator
    separator = "|"
    input_data = "abc|def|ghi"

    assert_equal(
      input_data.split(separator).length, RunLengthEncodingRb.encode(
        input_data,
        separator
      ).length
    )
  end
end
