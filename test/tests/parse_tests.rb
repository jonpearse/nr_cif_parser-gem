require 'test_helper'

class TestFieldTypes < MiniTest::Test

  DATA_ROOT = File.dirname( File.dirname( __FILE__ )) + '/data/'
  SHORT_FILE = "#{DATA_ROOT}/short.cif"
  GAPPY_FILE = "#{DATA_ROOT}/short_with_gaps.cif"

  FILE_RECORDS = %w{ HD TI TI TI TI TI TI TI TI TI AA AA AA AA BS BX LO LI LI LI CR LI LI LI LI LI LI LI LT ZZ }
  FILE_STATS = { parsed: 30, records: 30, skipped: 0 }

  def test_file_length

    parser = NrCifParser::Parser.new( SHORT_FILE )

    assert_equal 30, parser.record_count

  end

  def test_file_length_with_gaps

    parser = NrCifParser::Parser.new( GAPPY_FILE )

    assert_equal 38, parser.record_count

  end

  def test_parse_types

    parser = NrCifParser::Parser.new( SHORT_FILE )

    types = []
    assert_equal FILE_STATS, parser.each{ |record| types << record.class.code }
    assert_equal FILE_RECORDS, types

  end

  def test_parse_types_with_gaps

    parser = NrCifParser::Parser.new( GAPPY_FILE )

    types = []
    assert_equal FILE_STATS, parser.each{ |record| types << record.class.code }
    assert_equal FILE_RECORDS, types

  end

  def test_specific_parsing

    parser = NrCifParser::Parser.new( SHORT_FILE )

    stats = { records: 30, parsed: 9, skipped: 21 }
    assert_equal stats, parser.each([ 'TI' ]){}

    stats = { records: 30, parsed: 10, skipped: 20 }
    assert_equal stats, parser.each([ 'TI', 'BX' ]){}

  end

  def test_specific_parsing_with_gaps

    parser = NrCifParser::Parser.new( GAPPY_FILE )

    stats = { records: 30, parsed: 9, skipped: 21 }
    assert_equal stats, parser.each([ 'TI' ]){}

    stats = { records: 30, parsed: 10, skipped: 20 }
    assert_equal stats, parser.each([ 'TI', 'BX' ]){}

  end

end
