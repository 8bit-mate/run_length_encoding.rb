# frozen_string_literal: true

#
# RunLengthEncodingRb#decode method allows to pass an array of a
# 'duck-typed' data (should response to the #chunk & #run_length).
#
# An exception should be raised if an object doesn't response to
# these methods.
#
# The module provides different classes to test such cases.
#
module MockDataClasses
  #
  # Doesn't have instant variables @run_length &
  # @chunk.
  #
  class ElementHasNoInstantVars
    def initialize
      @foo = "bar"
    end
  end

  #
  # Has instant variables, but they are not accessible,
  # since the lack of the attr_reader / attr_accessor.
  #
  class ElementHasInaccessibleInstantVars
    def initialize
      @chunk = "foo"
      @run_length = 0
    end
  end

  #
  # Complies with the requirements.
  #
  class CorrectElement
    attr_reader :chunk, :run_length

    def initialize(chunk: nil, run_length: nil)
      @chunk = chunk
      @run_length = run_length
    end
  end
end
