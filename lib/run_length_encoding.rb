# frozen_string_literal: true

require_relative "run_length_encoding/version"
require_relative "decoder"
require_relative "encoder"

#
# Provides methods to encode and decode data using RLE.
#
class RunLengthEncoding
  include Encoder
  include Decoder

  def initialize(*); end
end
