require 'test_helper'

class TestTDRecord < BaseRecordTest

  # SETUP

  def class_under_test

    NrCifParser::Record::TiplocDelete

  end

  def example_message

    'TDABGLELE'

  end

  # ACTUAL TESTS

  def test_tiploc

    assert_equal 'ABGLELE', record.tiploc

    should_fail 'TD       '

  end

end
