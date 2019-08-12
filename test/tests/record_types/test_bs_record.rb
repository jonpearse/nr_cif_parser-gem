require 'test_helper'

class TestBSRecord < BaseRecordTest

  # SETUP

  RUNNING_DAYS = {
    monday: true,
    tuesday: true,
    wednesday: false,
    thursday: false,
    friday: true,
    saturday: false,
    sunday: false
  }

  def class_under_test

    NrCifParser::Record::BasicSchedule

  end

  def example_message

    'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      S            O'

  end

  # TESTS

  def test_train_uid

    assert_equal "G82885", record.train_uid

    should_fail 'BSR8828851510191510231100100 POO2N75    113575825 DMUE   090      S            O'
    should_fail 'BSR88Q8851510191510231100100 POO2N75    113575825 DMUE   090      S            O'

  end

  def test_date_from

    assert_equal Date.new( 2015, 10, 19), record.date_from
    should_fail 'BSQG828851510A91510231100100 POO2N75    113575825 DMUE   090      S            O'

  end

  def test_date_until

    assert_equal Date.new( 2015, 10, 23 ), record.date_until

  end

  def test_days

    r = record

    assert_equal 100, r.days_run
    assert_equal true, r.on_monday?
    assert_equal false, r.on_wednesday?
    assert_equal RUNNING_DAYS.values, r.running_days
    assert_equal RUNNING_DAYS, r.running_days_in_words

  end

  def test_bank_holiday

    assert_nil record.bank_holiday
    assert_equal "X", parse( 'BSRG828851510191510231100100XPOO2N75    113575825 DMUE   090      S            O' ).bank_holiday
    should_fail 'BSRG828851510191510231100100QPOO2N75    113575825 DMUE   090      S            O'

  end

  def test_status

    assert_equal "P", record.status
    should_fail 'BSRG828851510191510231100100Q9OO2N75    113575825 DMUE   090      S            O'
    should_fail 'BSRG828851510191510231100100QXOO2N75    113575825 DMUE   090      S            O'

  end

  def test_category

    assert_equal "OO", record.category

  end

  def test_identity

    assert_equal "2N75", record.identity
    should_fail 'BSRG828851510191510231100100 POO2575    113575825 DMUE   090      S            O', 'Number instead of letter'
    should_fail 'BSRG828851510191510231100100 POOE575    113575825 DMUE   090      S            O', 'Initial letter instead of number'
    should_fail 'BSRG828851510191510231100100 POO25E5    113575825 DMUE   090      S            O', 'Third letter instead of number'
    should_fail 'BSRG828851510191510231100100 POO257E    113575825 DMUE   090      S            O', 'Fourth letter instead of number'

  end

  def test_headcode

    assert_nil record.headcode

  end

  def test_service_code

    assert_equal 13575825, record.service_code
    should_fail 'BSRG828851510191510231100100 POO2N75    11X575825 DMUE   090      S            O'

  end

  def test_portion_id

    assert_nil record.portion_id
    assert_equal 'Z', parse( 'BSNG828851510191510231100100 POO2N75    113575825ZDMUE   090      S            O' ).portion_id
    should_fail 'BSRG828851510191510231100100 POO2N75    11X5758255DMUE   090      S            O'
    should_fail 'BSRG828851510191510231100100 POO2N75    11X575825XDMUE   090      S            O'

  end

  def test_power_type

    assert_equal 'DMU', record.power_type
    assert_equal 'ED', parse( 'BSNG828851510191510231100100 POO2N75    113575825ZED E   090      S            O' ).power_type
    should_fail 'BSRG828851510191510231100100 POO2N75    11X575825XXX E   090      S            O'

  end

  def test_timing_load

    assert_equal 'E', record.timing_load

    assert_equal '1234', parse( 'BSRG828851510191510231100100 POO2N75    113575825 DMU1234090      S            O' ).timing_load
    assert_equal 'D3',  parse( 'BSRG828851510191510231100100 POO2N75    113575825 DMUD3  090      S            O' ).timing_load
    should_fail 'BSRG828851510191510231100100 POO2N75    113575825 DMUF   090      S            O'
    should_fail 'BSRG828851510191510231100100 POO2N75    113575825 DMUFX  090      S            O'
    should_fail 'BSRG828851510191510231100100 POO2N75    113575825 DMUE0  090      S            O'

  end

  def test_speed

    assert_equal 90, record.speed

  end

  def test_operating_characteristics

    assert_nil record.op_character

    assert_equal "BEG", parse( 'BSRG828851510191510231100100 POO2N75    113575825 DMUD3  090BEG   S            O' ).op_character
    should_fail 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090XXXXXSS            O'

  end

  def test_seating_class

    assert_equal "S", record.seating_class

    assert_nil parse( 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090                   O' ).seating_class
    should_fail 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      X            O'

  end

  def test_sleepers

    assert_nil record.sleepers

    assert_equal 'B', parse( 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      SB           O' ).sleepers
    should_fail 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      SX           O'

  end

  def test_reservations

    assert_nil record.reservations

    assert_equal 'A', parse( 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      S A          O' ).reservations
    should_fail 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      S X          O'

  end

  def test_catering_code

    assert_nil record.catering_code

    assert_equal 'C', parse( 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      S   C        O' ).catering_code
    assert_equal 'TF', parse( 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      S   TF       O' ).catering_code
    should_fail 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      S   X        O'
    should_fail 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      S   XX       O'

  end

  def test_service_brand

    assert_nil record.service_brand

    assert_equal 'E', parse( 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      S       E    O' ).service_brand
    should_fail 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      S       EX   O'
    should_fail 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      S       X  X O'

  end

  def test_stp_indicator

    assert_equal "O", record.stp_indicator

    assert_equal 'C', parse( 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      S            C' ).stp_indicator
    should_fail 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      S            X'
    should_fail 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      S             '


  end

end
