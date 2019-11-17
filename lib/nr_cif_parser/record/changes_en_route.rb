module NrCifParser::Record

  class ChangesEnRoute < Base

    protected

    def self.code

      'CR'

    end

    def self.definition
      @@_definition ||= {
        location:         FT::String.new( 7 ),
        location_suffix:  FT::Char.new( true ),
        category:         FT::String.new( 2, true ), # @TODO: expand to ENUM
        identity:         FT::String.new( 4, true, /(\d[A-Z]\d\d|\s)/ ),
        headcode:         FT::String.new( 4, true ), # spec says number, but real data includes letters for bus routes
        indicator:        FT::Unused.new( 1 ),
        service_code:     FT::Number.new( 8, false, true ),
        portion_id:       FT::Char.new( true, /[ Z01248]/ ),
        power_type:       FT::Enum.new( %w{ D DEM DMU E ED EML EMU HST }, true ),
        timing_load:      FT::String.new( 4, true, /\A(A|E|N|S|T|V|X|D[1-3]|\d{1,4})?\s*\Z/ ),
        speed:            FT::Number.new( 3, false, true ),
        op_character:     FT::String.new( 6, true, /\A[BCDEGMPQRSYZ]*\s*\Z/ ),
        seating_class:    FT::Enum.new( %w{ B S }, true ),
        sleepers:         FT::Enum.new( %w{ B F S }, true ),
        reservations:     FT::Enum.new( %w{ A E R S }, true ),
        connection:       FT::Unused.new( 1 ),
        catering_code:    FT::String.new( 4, true, /\A[CFHMRT]*\s*\Z/ ),
        service_brand:    FT::String.new( 4, true, /\A(E|U)?\s*\Z/ ),
        traction_class:   FT::Unused.new( 4 ),
        uic_code:         FT::Number.new( 5, true )
      }
    end

  end

end

NrCifParser::register_record_type( NrCifParser::Record::ChangesEnRoute )
