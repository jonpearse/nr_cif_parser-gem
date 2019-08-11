require 'test_helper'

class TestTARecord < BaseRecordTest

  # SETUP

  def class_under_test

    NrCifParser::Record::TiplocAmend

  end

  def example_message

    'TAABGLELE00244800AABERGELE & PENSARN        40073   0AGLABERGELE & PENSNXYZABCD'

  end

  # TESTS

  def test_tiploc

    assert_equal 'ABGLELE', record.tiploc

    should_fail 'TA       00244800AABERGELE & PENSARN        40073   0AGLABERGELE & PENSNXYZABCD'

  end

  def test_capitals_id

    assert_equal 0, record.capitals_id

    should_fail 'TAABGLELEXY244800AABERGELE & PENSARN        40073   0AGLABERGELE & PENSNXYZABCD', 'Letter in number field'
    should_fail 'TAABGLELE  244800AABERGELE & PENSARN        40073   0AGLABERGELE & PENSNXYZABCD', 'Empty number field'

  end

  def test_nalco

    assert_equal 244800, record.nalco

    should_fail 'TAABGLELE002X4800AABERGELE & PENSARN        40073   0AGLABERGELE & PENSNXYZABCD', 'Letter in number field'
    should_fail 'TAABGLELE00      AABERGELE & PENSARN        40073   0AGLABERGELE & PENSNXYZABCD', 'Letter in number field'

  end

  def test_nlc_check_number

    assert_equal 'A', record.nlc_check_num

    assert_nil parse( 'TAABGLELE00244800 ABERGELE & PENSARN        40073   0AGLABERGELE & PENSNXYZABCD' ).nlc_check_num

  end

  def test_tps_description

    assert_equal 'ABERGELE & PENSARN', record.tps_description

    assert_nil parse( 'TAABGLELE00244800A                          40073   0AGLABERGELE & PENSNXYZABCD' ).tps_description

  end

  def test_stanox

    assert_equal 40073, record.stanox

    assert_equal 0, parse( 'TAABGLELE00244800AABERGELE & PENSARN        00000   0AGLABERGELE & PENSNXYZABCD' ).stanox
    should_fail 'TAABGLELE00244800AABERGELE & PENSARN                0AGLABERGELE & PENSNXYZABCD'

  end

  def test_po_mcp_code

    assert_equal 0, record.po_mcp_code

    assert_equal 1234, parse( 'TAABGLELE00244800AABERGELE & PENSARN        400731234AGLABERGELE & PENSNXYZABCD' ).po_mcp_code
    should_fail 'TAABGLELE00244800AABERGELE & PENSARN        40073    AGLABERGELE & PENSNXYZABCD'

  end

  def test_crs_code

    assert_equal 'AGL', record.crs_code

    assert_nil parse( 'TAABGLELE00244800AABERGELE & PENSARN        40073   0   ABERGELE & PENSNXYZABCD' ).crs_code

  end

  def test_description

    assert_equal 'ABERGELE & PENSN', record.description

    assert_equal 'SOME OTHER VALUE', parse( 'TAABGLELE00244800AABERGELE & PENSARN        40073   0AGLSOME OTHER VALUEXYZABCD' ).description
    assert_nil parse( 'TAABGLELE00244800AABERGELE & PENSARN        40073   0AGL                XYZABCD' ).description

  end

  def test_new_tiploc

    assert_equal 'XYZABCD', record.new_tiploc

    assert_nil parse( 'TAABGLELE00244800AABERGELE & PENSARN        40073   0AGLSOME OTHER VALUE       ' ).new_tiploc

  end

end
