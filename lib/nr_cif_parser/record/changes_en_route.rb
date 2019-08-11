module NrCifParser::Record

  class ChangesEnRoute < Base

    protected

    def self.code

      'CR'

    end

    def self.definition
      {
        location:         FieldTypes::String.new( 7 ),
        location_suffix:  FieldTypes::Char.new( true ),
        category:         FieldTypes::String.new( 2 ), # @TODO: expand to ENUM
        identity:         FieldTypes::String.new( 4, false, /\d[A-Z]\d\d/ ),
        headcode:         FieldTypes::Number.new( 4, true ),
        indicator:        FieldTypes::Unused.new( 1 ),
        service_code:     FieldTypes::Number.new( 8 ),
        portion_id:       FieldTypes::Char.new( true, /[ Z1248]/ ),
        power_type:       FieldTypes::Enum.new( %w{ D DEM DMU E ED EML EMU HST }),
        timing_load:      FieldTypes::String.new( 4, true, /\A(A|E|N|S|T|V|X|D[1-3]|\d{1,4})\s*\Z/ ),
        speed:            FieldTypes::Number.new( 3 ),
        op_character:     FieldTypes::String.new( 6, true, /\A[BCDEGMPQRSYZ]*\s*\Z/ ),
        seating_class:    FieldTypes::Enum.new( %w{ B S }, true ),
        sleepers:         FieldTypes::Enum.new( %w{ B F S }, true ),
        reservations:     FieldTypes::Enum.new( %w{ A E R S }, true ),
        connection:       FieldTypes::Unused.new( 1 ),
        catering_code:    FieldTypes::String.new( 4, true, /\A[CFHMRT]*\s*\Z/ ),
        service_brand:    FieldTypes::String.new( 4, true, /\AE?\s*\Z/ ),
        traction_class:   FieldTypes::Unused.new( 4 ),
        uic_code:         FieldTypes::Number.new( 5, true )
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::ChangesEnRoute )
