# frozen_string_literal: true

require_relative "constants"

#
# Set of checks of a single element to decode.
#
module DecodingElementCheck
  include Constants

  private

  #
  # Check if element obj complies with the following requirements:
  # 1. is a hash;
  # 2. has keys:
  #   - Constants::CHUNK_KEY (repeating element),
  #   - Constants::COUNT_KEY (how many times element is repeating);
  # 3. COUNT_KEY's value is an Integer;
  # 4. COUNT_KEY's value is a positive number.
  #
  # @param [Object] obj
  #   Object to check.
  #
  # @return [Hash{ Symbol => Object }] result
  #   Result of checks.
  #   If all checks are passed:
  #     result = { comply: true }
  #
  #   If a check is failed, result also contains exception type and exception message:
  #     result = { comply: false, ex_type: Exception, ex_msg: String }
  #
  def _valid_hash?(obj)
    check_list = [
      method(:_a_hash?),
      method(:_valid_keys?),
      method(:_count_is_integer?),
      method(:_count_is_positive?)
    ]

    for method in check_list
      result = method.call(obj)
      break unless result[:comply]
    end

    result
  end

  # Check if obj is a hash.
  def _a_hash?(obj)
    if obj.is_a?(Hash)
      {
        comply: true
      }
    else
      {
        ex_type: TypeError,
        ex_msg: "wrong argument type #{obj.class} (expected Hash)",
        comply: false
      }
    end
  end

  # Check if hash has valid keys.
  def _valid_keys?(hash)
    if hash.key?(CHUNK_KEY) && hash.key?(COUNT_KEY)
      {
        comply: true
      }
    else
      {
        ex_type: ArgumentError,
        ex_msg: "hash #{hash} has wrong keys (key is missing or has a wrong name)",
        comply: false
      }
    end
  end

  # Check if count is an Integer.
  def _count_is_integer?(hash)
    if hash[COUNT_KEY].is_a?(Integer)
      {
        comply: true
      }
    else
      {
        ex_type: TypeError,
        ex_msg: "wrong argument type #{hash[COUNT_KEY].class} (expected Integer)",
        comply: false
      }
    end
  end

  # Check if count is a positive number.
  def _count_is_positive?(hash)
    if hash[COUNT_KEY].positive?
      {
        comply: true
      }
    else
      {
        ex_type: ArgumentError,
        ex_msg: "error in #{hash}: count should be a positive Integer",
        comply: false
      }
    end
  end
end
