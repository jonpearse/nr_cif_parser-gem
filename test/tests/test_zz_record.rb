require 'test_helper'

class TestZZRecord < BaseRecordTest

  # SETUP

  def class_under_test

    NrCifParser::Record::Trailer

  end

  def example_message

    'ZZ'

  end

end
