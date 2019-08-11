require 'nr_cif_parser'
require 'minitest/autorun'

class BaseRecordTest < Minitest::Test

  # Common tests

  def test_invalid_message

    # this is messy, but we only want to run on subclasses, not here
    return if self.class == BaseRecordTest

    # common tests
    should_fail 'XX THIS SHOULD FAIL', 'Invalid message type'
    should_fail "#{class_under_test.code}XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 'Garbage message'

  end

  # These methods should be overridden by subclasses
  protected

  def class_under_test

    raise StandardError, "Calling class_under_test on BaseTest"

  end

  def example_message

    raise StandardError, "Calling example_message on BaseTest"

  end

  # For use elsewhere

  def parse( msg )

    class_under_test.parse( msg )

  end

  def record

    parse( example_message )

  end

  def should_fail( raw, msg = nil )

    assert_raises( NrCifParser::RecordParserError, msg ) do

      parse( raw )

    end

  end

end
