# frozen_string_literal: true

#
# Provides methods to generate random data.
#
module RandomDataMixin
  ARR_LENGTH = 100_000
  STRING_LENGTH = 100_000 # elements, not characters
  SEPARATOR = "|"

  private

  #
  # Generate a random array, those elements can have only three
  # values: "foo", "bar" or "buzz"
  #
  # @option [Integer] arr_length (ARR_LENGTH)
  #   Desired array length.
  #
  # @return [Array<String>]
  #
  def _generate_random_array(arr_length: ARR_LENGTH)
    Array.new(arr_length) do
      case rand(3)
      when 0
        "foo"
      when 1
        "bar"
      when 2
        "buzz"
      end
    end
  end

  #
  # Generate a random string, those elements can have only three
  # values: "foo", "bar" or "buzz"
  #
  # @option [Integer] n_elenents (STRING_LENGTH)
  # @option [String] separator (SEPARATOR)
  #
  # @return [String]
  #
  def _generate_random_string(n_elenents: STRING_LENGTH, separator: SEPARATOR)
    _generate_random_array(arr_length: n_elenents).join(separator)
  end
end
