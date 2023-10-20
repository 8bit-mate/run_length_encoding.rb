# frozen_string_literal: true

module RunLengthEncodingRb
  #
  # Stores an run-length encoded element.
  #
  class RLEElement
    attr_accessor :chunk, :run_length

    def initialize(chunk:, run_length:)
      @chunk = chunk
      @run_length = run_length
    end
  end
end
