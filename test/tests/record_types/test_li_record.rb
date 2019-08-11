require 'test_helper'

class TestLiRecord < BaseRecordTest

  # SETUP

  def class_under_test

    NrCifParser::Record::IntermediateLocation

  end

  def example_message

    'LICROY              1720 000000001                      1H  '

  end

  # TESTS

  def test_location

    assert_equal 'CROY', record.location

  end

  def test_scheduled_arrival

    assert_nil record.schedule_arrival

    assert_equal "12:00:00", parse( 'LICROY    1200      1720 000000001                      1H  ' ).schedule_arrival
    assert_equal "12:00:30", parse( 'LICROY    1200H     1720 000000001                      1H  ' ).schedule_arrival

  end

  def test_scheduled_departure

    assert_nil record.schedule_depart

    assert_equal "12:00:30", parse( 'LICROY         1200H1720 000000001                      1H  ' ).schedule_depart

  end

  def test_scheduled_pass

    assert_equal '17:20:00', record.schedule_pass
    assert_equal "17:20:30", parse( 'LICROY              1720H000000001                      1H  ' ).schedule_pass

  end

  def test_public_arrival

    assert_equal '00:00:00', record.public_arrival
    assert_equal "17:20:00", parse( 'LICROY              1720 172000001                      1H  ' ).public_arrival

  end

  def test_public_departure

    assert_equal '00:00:00', record.public_depart
    assert_equal "17:20:00", parse( 'LICROY              1720 000017201                      1H  ' ).public_depart

  end

  def test_platform

    assert_equal "1", record.platform
    assert_nil parse( 'LICROY              1720 00000000                       1H  ' ).platform

  end

  def test_line

    assert_nil record.line
    assert_equal "UMF", parse( 'LICROY              1720 00000000   UMF                 1H  ' ).line

  end

  def test_path

    assert_nil record.path
    assert_equal "UMF", parse( 'LICROY              1720 00000000      UMF              1H  ' ).path

  end

  def test_activity

    assert_equal [], record.activity
    assert_equal [ 'X', '-U' ], parse( 'LICROY              1720 00000000         X -U          1H  ' ).activity
    should_fail 'LICROY              1720 00000000         X ZZ          1H  ', 'Invalid ZZ activity'

  end

  def test_eng_allowance

    assert_equal 0, record.eng_allowance

    assert_equal 91, parse( 'LICROY              1720 000000001                    911H  ' ).eng_allowance
    assert_equal 9.5, parse( 'LICROY              1720 000000001                    9H1H  ' ).eng_allowance
    should_fail 'LICROY              1720 000000001                    9X1H  '
    should_fail 'LICROY              1720 000000001                    X 1H  '

  end

  def test_path_allowance

    assert_equal 1.5, record.path_allowance

    should_fail 'LICROY              1720 000000001                      9X  '
    should_fail 'LICROY              1720 000000001                      X   '

  end

  def test_perf_allowance

    assert_equal 0, record.perf_allowance

    assert_equal 91, parse( 'LICROY              1720 000000001                      1H91' ).perf_allowance
    assert_equal 9.5, parse( 'LICROY              1720 000000001                      1H9H' ).perf_allowance
    should_fail 'LICROY              1720 000000001                      1H9X'
    should_fail 'LICROY              1720 000000001                      1HX '

  end

end
