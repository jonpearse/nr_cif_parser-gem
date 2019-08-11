require 'test_helper'

class TestLtRecord < Minitest::Test

  # SETUP

  def arb_parse( msg )

    NrCifParser::Record::TerminatingLocation.parse( msg )

  end

  def record

    arb_parse( 'LTFALKRKG 1734 17341     TF         ' )

  end

  def should_fail( raw, msg = nil )

    assert_raises( NrCifParser::RecordParserError, msg ) do

      arb_parse( raw )

    end

  end


  # ACTUAL TESTS

  def test_invalid_message

    should_fail 'XX THIS SHOULD FAIL'
    should_fail 'LTXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

  end

  def test_location

    assert_equal 'FALKRKG', record.location

  end

  def test_scheduled_arrival

    assert_equal "17:34:00", record.schedule_arrival

    assert_equal "17:34:30", arb_parse( 'LTFALKRKG 1734H17341     TF         ' ).schedule_arrival
    should_fail 'LTFALKRKG     17341     TF         '

  end

  def test_public_arrival

    assert_equal "17:34:00", record.public_arrival

    should_fail 'LTFALKRKG 1734     1     TF         '

  end

  def test_platform

    assert_equal "1", record.platform
    assert_nil arb_parse( 'LTFALKRKG 1734 1734      TF         ' ).platform

  end

  def test_path

    assert_nil record.path
    assert_equal "UMF", arb_parse( 'LTFALKRKG 1734 1734   UMFTF         ' ).path

  end

  def test_activity

    assert_equal [ 'TF' ], record.activity

    should_fail 'LTFALKRKG 1734 1734                 ', 'Missing required TF'
    should_fail 'LTFALKRKG 1734 17341     TFZZ       ', 'Unknown acivity ZZ'

  end

end
