require 'test_helper'

class TestTDRecord < Minitest::Test

  # SETUP

  def arb_parse( msg )

    NrCifParser::Record::TiplocDelete.parse( msg )

  end

  def record

    arb_parse( 'TDABGLELE' )

  end

  def should_fail( raw, msg = nil )

    assert_raises( NrCifParser::RecordParserError, msg ) do

      arb_parse( raw )

    end

  end


  # ACTUAL TESTS

  def test_invalid_message

    should_fail 'XX THIS SHOULD FAIL'
    should_fail 'TDXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

  end

  def test_tiploc

    assert_equal 'ABGLELE', record.tiploc

    should_fail 'TD       '

  end

end
