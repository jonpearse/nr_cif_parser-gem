require 'test_helper'

class TestBXRecord < BaseRecordTest

  # SETUP

  def class_under_test

    NrCifParser::Record::BasicScheduleExtraDetails

  end

  def example_message

    'BX         SRY'

  end

  # ACTUAL TESTS

  def test_uic_code

    assert_nil record.uic_code

    assert_equal 12345, arb_parse( 'BX    12345SRY' ).uic_code

  end

  def atoc_code

    assert_equal 'SR', record.atoc_code

    should_fail 'BX           Y'

  end

  def applicable_tt_code

    assert_equal 'Y', record.applicable_tt_code

    assert_equal 'N', arb_parse( 'BX         SRN' ).applicable_tt_code
    should_fail 'BX         SRX', 'Invalid TT code'
    should_fail 'BX         SR ', 'Blank TT code'

  end

end
