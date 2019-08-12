require 'test_helper'

class TestFieldTypes < MiniTest::Test

  def test_aa_detection

    assert_equal NrCifParser::get_record_module_for( 'AA' ), NrCifParser::Record::Association

  end

  def test_bs_detection

    assert_equal NrCifParser::get_record_module_for( 'BS' ), NrCifParser::Record::BasicSchedule

  end

  def test_bx_detection

    assert_equal NrCifParser::get_record_module_for( 'BX' ), NrCifParser::Record::BasicScheduleExtraDetails

  end

  def test_cr_detection

    assert_equal NrCifParser::get_record_module_for( 'CR' ), NrCifParser::Record::ChangesEnRoute

  end

  def test_hd_detection

    assert_equal NrCifParser::get_record_module_for( 'HD' ), NrCifParser::Record::Header

  end

  def test_li_detection

    assert_equal NrCifParser::get_record_module_for( 'LI' ), NrCifParser::Record::IntermediateLocation

  end

  def test_lo_detection

    assert_equal NrCifParser::get_record_module_for( 'LO' ), NrCifParser::Record::OriginLocation

  end

  def test_lt_detection

    assert_equal NrCifParser::get_record_module_for( 'LT' ), NrCifParser::Record::TerminatingLocation

  end

  def test_ta_detection

    assert_equal NrCifParser::get_record_module_for( 'TA' ), NrCifParser::Record::TiplocAmend

  end

  def test_td_detection

    assert_equal NrCifParser::get_record_module_for( 'TD' ), NrCifParser::Record::TiplocDelete

  end

  def test_ti_detection

    assert_equal NrCifParser::get_record_module_for( 'TI' ), NrCifParser::Record::TiplocInsert

  end

  def test_zz_detection

    assert_equal NrCifParser::get_record_module_for( 'ZZ' ), NrCifParser::Record::Trailer

  end

end
