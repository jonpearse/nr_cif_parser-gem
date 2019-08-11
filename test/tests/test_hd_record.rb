require 'test_helper'

class TestHDRecord < BaseRecordTest

  # SETUP

  def class_under_test

    NrCifParser::Record::Header

  end

  def example_message

    'HDTPS.ABCDEF1.PD1908090908191947XYZ123A       FA090819080820'

  end

  # ACTUAL TESTS

  def file_mainframe_id

    assert_equal 'TPS.ABCDEF1.PD190809', record.file_mainframe_id

    should_fail  'HD                    0908191947XYZ123A       FA090819080820'

  end

  def date_of_extract

    assert_equal Date.new( 2019, 8, 9 ), record.date_of_extract

    should_fail 'HDTPS.ABCDEF1.PD190809      1947XYZ123A       FA090819080820', 'Blank date'

  end

  def time_of_extract

    assert_equal '19:47:00', record.time_of_extract

    should_fail 'HDTPS.ABCDEF1.PD1908090908192447XYZ123A       FA090819080820', 'Invalid time'
    should_fail 'HDTPS.ABCDEF1.PD190809090819244XXYZ123A       FA090819080820', 'Invalid time format'
    should_fail 'HDTPS.ABCDEF1.PD190809090819    XYZ123A       FA090819080820', 'Missing time'

  end

  def test_current_file_ref

    assert_equal 'XYZ123A', record.current_file_ref

    should_fail 'HDTPS.ABCDEF1.PD1908090908191947              FA090819080820', 'Empty file reference'

  end

  def test_last_file_ref

    assert_nil record.last_file_ref

    assert_equal 'ABC123X', arb_parse( 'HDTPS.ABCDEF1.PD1908090908191947XYZ123AABC123XFA090819080820' ).last_file_ref

  end

  def test_bleed_off_ind

    assert_equal 'F', record.bleed_off_ind

    should_fail 'HDTPS.ABCDEF1.PD1908090908191947XYZ123A        A090819080820', 'Missing value'

  end

  def test_version

    assert_equal 'A', record.version

    should_fail 'HDTPS.ABCDEF1.PD1908090908191947XYZ123A       F 090819080820', 'Missing value'

  end

  def test_user_extract_start

    assert_equal Date.new( 2019, 8, 9 ), record.user_extract_start

    should_fail 'HDTPS.ABCDEF1.PD1908090908191947XYZ123A       FA      080820', 'Blank date'

  end

  def test_user_extract_end

    assert_equal Date.new( 2020, 8, 8 ), record.user_extract_end

    should_fail 'HDTPS.ABCDEF1.PD1908090908191947XYZ123A       FA090819      ', 'Blank Date'

  end

end
