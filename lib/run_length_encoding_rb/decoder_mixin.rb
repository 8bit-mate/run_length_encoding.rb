# frozen_string_literal: true

module RunLengthEncodingRb
  #
  # Provides methods to validate #decode input data.
  #
  module DecoderMixin
    EXPECTED_ATTRIBUTES = %w[run_length chunk].freeze

    private

    #
    # Ensure that the obj complies with the following requirements:
    # 1. has instant variables:
    #   - obj.chunk;
    #   - obj.run_length;
    # 2. instant variables are accessible (i.e. has the attr_reader
    #    or the attr_accessor);
    # 3. obj.run_length is an Integer;
    # 4. obj.run_length is a positive Integer.
    #
    # @param [Object] obj
    #   Object to inspect.
    #
    def _inspect_element(obj)
      attrs_defined_status = _get_attrs_defined_status(obj, EXPECTED_ATTRIBUTES)
      attrs_access_status = _get_attr_accessibility_status(obj, EXPECTED_ATTRIBUTES)

      _ensure_element_has_defined_attrs(obj, attrs_defined_status)
      _ensure_element_has_accessible_attrs(obj, attrs_access_status)
      _ensure_length_int(obj)
      _ensure_length_non_negative(obj)
    end

    #
    # Ensure that element has defined attributes.
    #
    # @param [Object] obj
    #
    # @param [Hash{ String => Boolean }] attrs_status
    #
    # @raise [::AttrMissingError]
    #
    def _ensure_element_has_defined_attrs(obj, attrs_status)
      return if _all_pass?(attrs_status.values)

      raise(
        RunLengthEncodingRb::AttrMissingError,
        "the element #{obj} doesn't have the attribute(s): " \
        "#{_get_bad_attributes(attrs_status).join(", ")}"
      )
    end

    #
    # Ensure that element has accessible attributes.
    #
    # @param [Object] obj
    #
    # @param [Hash{ String => Boolean }] attrs_status
    #
    # @raise [::AttrInaccessibleError]
    #
    def _ensure_element_has_accessible_attrs(obj, attrs_status)
      return if _all_pass?(attrs_status.values)

      raise(
        RunLengthEncodingRb::AttrInaccessibleError,
        "in the element #{obj}, the following attribute(s) are inaccessible: " \
        "#{_get_bad_attributes(attrs_status).join(", ")} (attr_reader/attr_accessor is missing?)"
      )
    end

    #
    # Return an array of the attribute names that are
    # missing or inaccessible.
    #
    # @param [Hash{ String => Boolean }] hash
    #
    # @return [Array<String>]
    #
    def _get_bad_attributes(hash)
      hash.select { |_k, v| v == false }.keys
    end

    #
    # @param [Array<Boolean>] array
    #
    # @return [Boolean]
    #
    def _all_pass?(array)
      array.all? { |e| e == true }
    end

    #
    # Return the array of missing attributes.
    #
    # @param [Array<Boolean>] attr_accessibility
    #   Attributes accessability.
    #
    # @param [Array<String>] attrs_arr
    #
    # @return [Array<String>]
    #   Array of attributes that are not accessable.
    #
    def _missing_attributes(attr_accessibility, attrs_arr)
      (
        Hash[
          attrs_arr.zip(attr_accessibility)
        ].delete_if { |_k, v| v == true }
      ).keys
    end

    #
    # For the object 'obj', get attribute presence status for
    # each attribute name from the 'attrs_arr'.
    #
    # @param [Object] obj
    #   Object to inspect.
    #
    # @param [Array<String>] attrs_arr
    #   Array of attribute names.
    #
    # @return [Hash{ String => Boolean }]
    #
    def _get_attrs_defined_status(obj, attrs_arr)
      _get_attr_status(obj, attrs_arr) do |obj_to_check, attr_name|
        obj_to_check.instance_variable_defined?("@#{attr_name}")
      end
    end

    #
    # For the object 'obj', get attribute accessibility status for
    # each attribute from the 'attrs_arr'.
    #
    # @param [Object] obj
    #   Object to inspect.
    #
    # @param [Array<String>] attrs_arr
    #   Array of attribute names.
    #
    # @return [Hash{ String => Boolean }]
    #
    def _get_attr_accessibility_status(obj, attrs_arr)
      _get_attr_status(obj, attrs_arr) do |obj_to_check, attr_name|
        obj_to_check.respond_to?(attr_name)
      end
    end

    #
    # Abstract method to get statuses (true/false) for the elements
    # of the 'attrs_arr' input array. The actual check with a boolean
    # response should be handled by the block.
    #
    # @param [Object] obj
    #
    # @param [Array<String>] attrs_arr
    #
    # @yeld [obj_to_check, attr_name]
    #   Performs actual check for an element 'e'.
    #
    # @yieldparam [Object] obj_to_check
    #
    # @yieldparam [String] attr_name
    #
    # @yieldreturn [Boolean]
    #
    # @return [Hash{ String => Boolean }]
    #
    def _get_attr_status(obj, attrs_arr, &_block)
      statuses_arr = attrs_arr.map { |e| yield(obj, e) }
      Hash[attrs_arr.zip(statuses_arr)]
    end

    #
    # Ensure that run-length attribute of the element is an Integer.
    #
    # @param [Object] obj
    #
    # @raise [::TypeError]
    #
    def _ensure_length_int(obj)
      return if obj.run_length.is_a?(Integer)

      raise(
        RunLengthEncodingRb::TypeError,
        "wrong run-length type: #{obj.run_length.class} (expected Integer)"
      )
    end

    #
    # Ensure that run-length attribute of the element is a non-negative Integer.
    #
    # @param [Object] obj
    #
    # @raise [::NegativeIntError]
    #
    def _ensure_length_non_negative(obj)
      return if obj.run_length >= 0

      raise(
        RunLengthEncodingRb::NegativeIntError,
        "error in #{obj}: run-length should be a non-negative Integer"
      )
    end
  end
end
