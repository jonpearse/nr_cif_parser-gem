require 'test_helper'

class TestZZRecord < Minitest::Test

  # SETUP

  def arb_parse( msg )

    NrCifParser::Record::Trailer.parse( msg )

  end

  def record

    arb_parse( 'ZZ' )

  end

  def should_fail( raw, msg = nil )

    assert_raises( NrCifParser::RecordParserError, msg ) do

      arb_parse( raw )

    end

  end


  # ACTUAL TESTS

  def test_invalid_message

    should_fail 'XX THIS SHOULD FAIL'
    should_fail 'ZZXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

  end

end
