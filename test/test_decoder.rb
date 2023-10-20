# frozen_string_literal: true

require_relative "test_helper"
require_relative "mock_data_classes"

#
# Test the RunLengthEncodingRb::Decoder class.
#
class TestDecoder < Minitest::Test
  def test_raises_type_error_when_unsupported_input_data_type
    assert_raises RunLengthEncodingRb::TypeError do
      input_data = "foo bar" # Expected Array, but got String.
      RunLengthEncodingRb.decode(input_data)
    end
  end

  def test_return_array_when_supported_input_data_type
    input_data = []
    assert_instance_of Array, RunLengthEncodingRb.decode(input_data)
  end

  def test_return_empty_array_when_input_data_is_an_empty_array
    input_data = []
    assert_empty RunLengthEncodingRb.decode(input_data)
  end

  def test_raises_attr_missing_error_when_element_doesnt_have_attributes
    assert_raises RunLengthEncodingRb::AttrMissingError do
      input_data = [MockDataClasses::ElementHasNoInstantVars.new]
      RunLengthEncodingRb.decode(input_data)
    end
  end

  def test_raises_attr_missing_error_when_element_has_inaccessible_attributes
    assert_raises RunLengthEncodingRb::AttrInaccessibleError do
      input_data = [MockDataClasses::ElementHasInaccessibleInstantVars.new]
      RunLengthEncodingRb.decode(input_data)
    end
  end

  def test_raises_negative_int_error_when_negative_run_length
    assert_raises RunLengthEncodingRb::NegativeIntError do
      input_data = [MockDataClasses::CorrectElement.new(run_length: -5)]
      RunLengthEncodingRb.decode(input_data)
    end
  end

  def test_raises_type_error_when_run_length_isnt_integer
    assert_raises RunLengthEncodingRb::TypeError do
      input_data = [MockDataClasses::CorrectElement.new(run_length: "foo")]
      RunLengthEncodingRb.decode(input_data)
    end
  end

  def test_returns_empty_array_when_run_length_is_zero
    input_data = [MockDataClasses::CorrectElement.new(chunk: "foo", run_length: 0)]
    assert_empty RunLengthEncodingRb.decode(input_data)
  end

  def test_decode_array
    input_data = [
      MockDataClasses::CorrectElement.new(chunk: "foo", run_length: 0),
      MockDataClasses::CorrectElement.new(chunk: "bar", run_length: 3),
      MockDataClasses::CorrectElement.new(chunk: "foo", run_length: 1),
      MockDataClasses::CorrectElement.new(chunk: "bazz", run_length: 0)
    ]

    expected_output = %w[bar bar bar foo]
    assert_equal expected_output, RunLengthEncodingRb.decode(input_data)
  end
end
