require 'test_helper'

class TestAARecord < BaseRecordTest

  # SETUP

  ACTIVE_DAYS = {
    monday: false,
    tuesday: false,
    wednesday: false,
    thursday: false,
    friday: false,
    saturday: false,
    sunday: true
  }

  def class_under_test

    NrCifParser::Record::Association

  end

  def example_message

    'AANC03858Y030391905191909080000001NPSNWCSTLE  TO                               P'

  end

  # TESTS

  def test_transaction_type

    assert_equal 'N', record.type
    assert_equal 'R', arb_parse( 'AARC03858Y030391905191909080000001NPSNWCSTLE  TO                               P' ).type
    should_fail 'AAXC03858Y030391905191909080000001NPSNWCSTLE  TO                               P'

  end

  def test_main_uid

    assert_equal "C03858", record.main_uid

    should_fail 'AAN503858Y030391905191909080000001NPSNWCSTLE  TO                               P'
    should_fail 'AANCX3858Y030391905191909080000001NPSNWCSTLE  TO                               P'

  end

  def test_associated_uid

    assert_equal "Y03039", record.associated_uid

    should_fail 'AANC038585030391905191909080000001NPSNWCSTLE  TO                               P'
    should_fail 'AANC03858YX30391905191909080000001NPSNWCSTLE  TO                               P'

  end

  def test_date_from

    assert_equal Date.new( 2019, 5, 19), record.date_from

    should_fail 'AANC03858Y03039XX05191909080000001NPSNWCSTLE  TO                               P'

  end

  def test_date_until

    assert_equal Date.new( 2019, 9, 8 ), record.date_until

  end

  def test_days

    r = record

    assert_equal 1, r.days, 'Value of days bitfield'
    assert_equal false, r.on_monday?, 'Monday?'
    assert_equal true, r.on_sunday?, 'Sunday?'
    assert_equal ACTIVE_DAYS.values, r.running_days, 'Running days helper'
    assert_equal ACTIVE_DAYS, r.running_days_in_words, 'Running days words helper'

    should_fail 'AANC03858Y0303919051919090800X0001NPSNWCSTLE  TO                               P', 'Letter in field'
    should_fail 'AANC03858Y030391905191909080000002NPSNWCSTLE  TO                               P', 'Non-binary in field'
    should_fail 'AANC03858Y03039190519190908       NPSNWCSTLE  TO                               P', 'Blank field'

  end

  def test_category

    assert_equal 'NP', record.category

    assert_equal 'VV', arb_parse( 'AANC03858Y030391905191909080000001VVSNWCSTLE  TO                               P' ).category
    assert_equal 'JJ', arb_parse( 'AANC03858Y030391905191909080000001JJSNWCSTLE  TO                               P' ).category
    should_fail 'AANC03858Y030391905191909080000001XXSNWCSTLE  TO                               P', 'Invalid specification'

  end

  def test_date_ind

    assert_equal 'S', record.date_ind

    assert_equal 'N', arb_parse( 'AANC03858Y030391905191909080000001NPNNWCSTLE  TO                               P' ).date_ind
    should_fail 'AANC03858Y030391905191909080000001NPXNWCSTLE  TO                               P', 'Invalid specification'

  end

  def test_location

    assert_equal 'NWCSTLE', record.location
    should_fail 'AANC03858Y030391905191909080000001NPS         TO                               P', 'Missing location'

  end

  def test_base_suffix

    assert_nil record.base_suffix

    assert_equal 4, arb_parse( 'AANC03858Y030391905191909080000001NPSNWCSTLE4 TO                               P' ).base_suffix
    should_fail 'AANC03858Y030391905191909080000001NPSNWCSTLEX TO                               P'

  end

  def test_assoc_suffix

    assert_nil record.assoc_suffix

    assert_equal 4, arb_parse( 'AANC03858Y030391905191909080000001NPSNWCSTLE 4TO                               P' ).assoc_suffix
    should_fail 'AANC03858Y030391905191909080000001NPSNWCSTLE XTO                               P'

  end

  def test_diagram_type

    assert_equal 'O', record.association_type
    assert_equal 'P', arb_parse( 'AANC03858Y030391905191909080000001NPSNWCSTLE  TP                               P' ).association_type
    assert_nil arb_parse( 'AANC03858Y030391905191909080000001NPSNWCSTLE  T                                P' ).association_type
    should_fail 'AANC03858Y030391905191909080000001NPSNWCSTLE  TX                               P'

  end

  def test_stp_indicator

    assert_equal 'P', record.stp_indicator
    assert_equal ' ', arb_parse( 'AANC03858Y030391905191909080000001NPSNWCSTLE  TO                                ' ).stp_indicator
    assert_equal 'C', arb_parse( 'AANC03858Y030391905191909080000001NPSNWCSTLE  TO                               C' ).stp_indicator
    assert_equal 'N', arb_parse( 'AANC03858Y030391905191909080000001NPSNWCSTLE  TO                               N' ).stp_indicator
    assert_equal 'O', arb_parse( 'AANC03858Y030391905191909080000001NPSNWCSTLE  TO                               O' ).stp_indicator
    should_fail 'AANC03858Y030391905191909080000001NPSNWCSTLE  TO                               X'

  end

end
