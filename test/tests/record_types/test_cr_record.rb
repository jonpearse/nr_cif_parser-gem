require 'test_helper'

class TestCRRecord < BaseRecordTest

  # SETUP

  def class_under_test

    NrCifParser::Record::ChangesEnRoute

  end

  def example_message

    'CRLENZIE  OO2N75    123578903 DMUE   090      S                    '

  end

  # TESTS

  def test_location

    assert_equal 'LENZIE', record.location

  end

  def test_category

    assert_equal 'OO', record.category

  end

  def test_identity

    assert_equal '2N75', record.identity
    should_fail 'CRLENZIE  OOXN75    123578903 DMUE   090      S                '
    should_fail 'CRLENZIE  OO2075    123578903 DMUE   090      S                '
    should_fail 'CRLENZIE  OO2NX5    123578903 DMUE   090      S                '
    should_fail 'CRLENZIE  OO2N7X    123578903 DMUE   090      S                '

  end

  def test_headcode

    assert_nil record.headcode

  end

  def test_service_code

    assert_equal 23578903, record.service_code
    should_fail 'CRLENZIE  OOXN75    12X578903 DMUE   090      S                '

  end

  def test_portion_id

    assert_nil record.portion_id
    assert_equal 'Z', parse( 'CRLENZIE  OO2N75    123578903ZDMUE   090      S                ' ).portion_id
    should_fail 'CRLENZIE  OO2N75    123578903XDMUE   090      S                '
    should_fail 'CRLENZIE  OO2N75    1235789035DMUE   090      S                '

  end

  def test_power_type

    assert_equal 'DMU', record.power_type
    assert_equal 'ED', parse( 'CRLENZIE  OO2N75    123578903ZED E   090      S                ' ).power_type
    should_fail 'CRLENZIE  OO2N75    123578903ZDXXE   090      S                '

  end

  def test_timing_load

    assert_equal 'E', record.timing_load

    assert_equal '1234', parse( 'CRLENZIE  OO2N75    123578903 DMU1234090      S                ' ).timing_load
    assert_equal 'D3',   parse( 'CRLENZIE  OO2N75    123578903 DMUD3  090      S                ' ).timing_load
    assert_nil parse( 'CRCTRDJN  DT3Q27    152495112 D      030' ).timing_load
    should_fail 'CRLENZIE  OO2N75    123578903 DMUF   090      S                '
    should_fail 'CRLENZIE  OO2N75    123578903 DMUFX  090      S                '
    should_fail 'CRLENZIE  OO2N75    123578903 DMUE0  090      S                '

  end

  def test_speed

    assert_equal 90, record.speed

    should_fail 'CRLENZIE  OO2N75    123578903 DMUE   X90      S                '

  end

  def test_operating_characteristics

    assert_nil record.op_character
    assert_equal 'BEG', parse( 'CRLENZIE  OO2N75    123578903 DMUE   090BEG   S                  ' ).op_character
    should_fail 'CRLENZIE  OO2N75    123578903 DMUE   090XXXXXXS                  '

  end

  def test_seating_class

    assert_equal 'S', record.seating_class

    assert_nil parse( 'CRLENZIE  OO2N75    123578903 DMUE   090                       ' ).seating_class
    should_fail 'CRLENZIE  OO2N75    123578903 DMUE   090      X                '

  end

  def test_sleepers

    assert_nil record.sleepers

    assert_equal 'B', parse( 'CRLENZIE  OO2N75    123578903 DMUE   090      SB               ' ).sleepers
    should_fail 'CRLENZIE  OO2N75    123578903 DMUE   090      SX               '

  end

  def test_reservations

    assert_nil record.reservations

    assert_equal 'A', parse( 'CRLENZIE  OO2N75    123578903 DMUE   090      S A              ' ).reservations
    should_fail 'CRLENZIE  OO2N75    123578903 DMUE   090      S X              '

  end

  def test_catering_code

    assert_nil record.catering_code

    assert_equal 'C',  parse( 'CRLENZIE  OO2N75    123578903 DMUE   090      S   C              ' ).catering_code
    assert_equal 'TF', parse( 'CRLENZIE  OO2N75    123578903 DMUE   090      S   TF             ' ).catering_code
    should_fail 'CRLENZIE  OO2N75    123578903 DMUE   090      S   X              '
    should_fail 'CRLENZIE  OO2N75    123578903 DMUE   090      S   XX             '

  end

  def test_service_brand

    assert_nil record.service_brand

    assert_equal 'E', parse( 'CRLENZIE  OO2N75    123578903 DMUE   090      S       E            ' ).service_brand
    should_fail 'CRLENZIE  OO2N75    123578903 DMUE   090      S       X            '
    should_fail 'CRLENZIE  OO2N75    123578903 DMUE   090      S       X X          '

  end

  def test_uic_code

    assert_nil record.uic_code

    assert_equal 12345, parse( 'CRLENZIE  OO2N75    123578903 DMUE   090      S               12345' ).uic_code
    should_fail 'CRLENZIE  OO2N75    123578903 DMUE   090      S               1234X'
    should_fail 'CRLENZIE  OO2N75    123578903 DMUE   090      S               XXXXX'

  end

end
