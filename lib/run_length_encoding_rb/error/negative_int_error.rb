# frozen_string_literal: true

module RunLengthEncodingRb
  #
  # Raises if run-length is negative.
  #
  class NegativeIntError < Error
    attr_reader :message

    def initialize(message = "")
      super(message)
    end
  end
end
