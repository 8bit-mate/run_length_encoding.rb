# frozen_string_literal: true

module RunLengthEncodingRb
  #
  # Raises if an element has inaccessible attribute
  # (misses attr_reader or attr_accessor).
  #
  class AttrInaccessibleError < Error
    attr_reader :message

    def initialize(message = "")
      super(message)
    end
  end
end
