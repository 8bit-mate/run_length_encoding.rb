# frozen_string_literal: true

require_relative "run_length_encoding/version"
require_relative "run_length_encoding/decoder"
require_relative "run_length_encoding/encoder"

#
# Provides methods to encode and decode data using RLE.
#
class RunLengthEncoding
  include Encoder
  include Decoder

  def initialize(*); end
end
