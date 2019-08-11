require 'test_helper'

class TestLoRecord < Minitest::Test

  # SETUP

  def arb_parse( msg )

    NrCifParser::Record::OriginLocation.parse( msg )

  end

  def record

    arb_parse( 'LOGLGQHL  1703 17033  UEG    TB            ' )

  end

  def should_fail( msg )

    assert_raises( NrCifParser::RecordParserError ) do

      arb_parse( msg )

    end

  end


  # ACTUAL TESTS

  def test_invalid_message

    should_fail 'XX THIS SHOULD FAIL'
    should_fail 'LOXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

  end

  def test_location

    assert_equal 'GLGQHL', record.location

  end

  def test_location_suffix

    assert_nil record.location_suffix

  end

  def test_scheduled_departure

    assert_equal '17:03:00', record.schedule_depart

    assert_equal '17:03:30', arb_parse( 'LOGLGQHL  1703H17033  UEG    TB                                                 ' ).schedule_depart
    should_fail 'LOGLGQHL  1703X17033  UEG    TB                                                 '

  end

  def test_public_departure

    assert_equal '17:03:00', record.public_depart
    should_fail 'LOGLGQHL  1703 170X3  UEG    TB                                                 '

  end

  def test_platform

    assert_equal '3', record.platform

  end

  def test_line

    assert_equal 'UEG', record.line

  end

  def test_eng_allowance

    assert_equal 0, record.eng_allowance

    assert_equal 30, arb_parse( 'LOGLGQHL  1703 17033  UEG30  TB                                                 ' ).eng_allowance
    assert_equal 9.5, arb_parse( 'LOGLGQHL  1703 17033  UEG9H  TB                                                 ' ).eng_allowance
    should_fail 'LOGLGQHL  1703 17033  UEG9X  TB                                                 '
    should_fail 'LOGLGQHL  1703 17033  UEGX   TB                                                 '

  end

  def test_path_allowance

    assert_equal 0, record.path_allowance

    assert_equal 30, arb_parse( 'LOGLGQHL  1703 17033  UEG  30TB                                                 ' ).path_allowance
    assert_equal 9.5, arb_parse( 'LOGLGQHL  1703 17033  UEG  9HTB                                                 ' ).path_allowance
    should_fail 'LOGLGQHL  1703 17033  UEG  9XTB                                                 '
    should_fail 'LOGLGQHL  1703 17033  UEG  X TB                                                 '

  end

  def test_activity

    skip

    assert_equal [ 'TB' ], record.activity
    assert_equal [ 'TB', 'X' ], arb_parse( 'LOGLGQHL  1703 17033  UEG    TBX                                                ' ).activity

    should_fail 'LOGLGQHL  1703 17033  UEG                                                       ', 'Missing TF activity'
    should_fail 'LOGLGQHL  1703 17033  UEG    ZZ                                                 ', 'False ZZ activity'

  end

  def test_perf_allowance

    assert_equal 0, record.perf_allowance

    assert_equal 30,  arb_parse( 'LOGLGQHL  1703 17033  UEG    TB          30' ).perf_allowance
    assert_equal 9.5, arb_parse( 'LOGLGQHL  1703 17033  UEG  9HTB          9H' ).perf_allowance
    should_fail 'LOGLGQHL  1703 17033  UEG    TB          9X'
    should_fail 'LOGLGQHL  1703 17033  UEG    TB          X '

  end

end
