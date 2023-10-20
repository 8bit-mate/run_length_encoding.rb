# frozen_string_literal: true

module RunLengthEncodingRb
  #
  # Base class.
  #
  class Error < ::StandardError
    attr_reader :message

    def initialize(message)
      @message = message
      super()
    end
  end
end
