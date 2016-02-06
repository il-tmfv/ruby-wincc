module WinccTagType
    def tag_type(type)
        case type
            when :bit
                'TAG_BINARY_TAG'
            when :sbyte
                'TAG_SIGNED_8BIT_VALUE'
            when :ubyte
                'TAG_UNSIGNED_8BIT_VALUE'
            when :sint16
                'TAG_SIGNED_16BIT_VALUE'
            when :uint16
                'TAG_UNSIGNED_16BIT_VALUE'
            when :sint32
                'TAG_SIGNED_32BIT_VALUE'
            when :uint32
                'TAG_UNSIGNED_32BIT_VALUE'
            when :float32
                'TAG_FLOATINGPOINT_NUMBER_32BIT_IEEE_754'
            when :float64
                'TAG_FLOATINGPOINT_NUMBER_64BIT_IEEE_754'
            when :text8
                'TAG_TEXT_TAG_8BIT_CHARACTER_SET'
            when :text16
                'TAG_TEXT_TAG_16BIT_CHARACTER_SET'
            when :ref
                'TAG_TEXT_REFERENCE'
            else 
                raise ArgumentError, "Incorrect tag type #{type}", caller
        end
    end
end