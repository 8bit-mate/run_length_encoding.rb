# frozen_string_literal: true

module RunLengthEncodingRb
  #
  # Raises if an element lacks attribute.
  #
  class AttrMissingError < Error
    attr_reader :message

    def initialize(message = "")
      super(message)
    end
  end
end
