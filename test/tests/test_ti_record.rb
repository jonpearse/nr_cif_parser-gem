require 'test_helper'

class TestTIRecord < Minitest::Test

  # SETUP

  def arb_parse( msg )

    NrCifParser::Record::TiplocInsert.parse( msg )

  end

  def record

    arb_parse( 'TIABGLELE00244800AABERGELE & PENSARN        40073   0AGLABERGELE & PENSN' )

  end

  def should_fail( raw, msg = nil )

    assert_raises( NrCifParser::RecordParserError, msg ) do

      arb_parse( raw )

    end

  end


  # ACTUAL TESTS

  def test_invalid_message

    should_fail 'XX THIS SHOULD FAIL'
    should_fail 'TIXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

  end

  def test_tiploc

    assert_equal 'ABGLELE', record.tiploc

    should_fail 'TI       00244800AABERGELE & PENSARN        40073   0AGLABERGELE & PENSN'

  end

  def test_capitals_id

    assert_equal 0, record.capitals_id

    should_fail 'TIABGLELEXY244800AABERGELE & PENSARN        40073   0AGLABERGELE & PENSN', 'Letter in number field'
    should_fail 'TIABGLELE  244800AABERGELE & PENSARN        40073   0AGLABERGELE & PENSN', 'Empty number field'

  end

  def test_nalco

    assert_equal 244800, record.nalco

    should_fail 'TIABGLELE002X4800AABERGELE & PENSARN        40073   0AGLABERGELE & PENSN', 'Letter in number field'
    should_fail 'TIABGLELE00      AABERGELE & PENSARN        40073   0AGLABERGELE & PENSN', 'Letter in number field'

  end

  def test_nlc_check_number

    assert_equal 'A', record.nlc_check_num

    assert_nil arb_parse( 'TIABGLELE00244800 ABERGELE & PENSARN        40073   0AGLABERGELE & PENSN' ).nlc_check_num

  end

  def test_tps_description

    assert_equal 'ABERGELE & PENSARN', record.tps_description

    assert_nil arb_parse( 'TIABGLELE00244800A                          40073   0AGLABERGELE & PENSN' ).tps_description

  end

  def test_stanox

    assert_equal 40073, record.stanox

    assert_equal 0, arb_parse( 'TIABGLELE00244800AABERGELE & PENSARN        00000   0AGLABERGELE & PENSN' ).stanox
    should_fail 'TIABGLELE00244800AABERGELE & PENSARN                0AGLABERGELE & PENSN'

  end

  def test_po_mcp_code

    assert_equal 0, record.po_mcp_code

    assert_equal 1234, arb_parse( 'TIABGLELE00244800AABERGELE & PENSARN        400731234AGLABERGELE & PENSN' ).po_mcp_code
    should_fail 'TIABGLELE00244800AABERGELE & PENSARN        40073    AGLABERGELE & PENSN'

  end

  def test_crs_code

    assert_equal 'AGL', record.crs_code

    assert_nil arb_parse( 'TIABGLELE00244800AABERGELE & PENSARN        40073   0   ABERGELE & PENSN' ).crs_code

  end

  def test_description

    assert_equal 'ABERGELE & PENSN', record.description

    assert_equal 'SOME OTHER VALUE', arb_parse( 'TIABGLELE00244800AABERGELE & PENSARN        40073   0AGLSOME OTHER VALUE' ).description
    assert_nil arb_parse( 'TIABGLELE00244800AABERGELE & PENSARN        40073   0AGL                ' ).description

  end

end
