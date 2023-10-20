# frozen_string_literal: true

module RunLengthEncodingRb
  #
  # Raises on incorrect data type.
  #
  class TypeError < Error
    attr_reader :message

    def initialize(message = "")
      super(message)
    end
  end
end
