require 'test_helper'

class TestBSRecord < Minitest::Test
  
  RUNNING_DAYS = {
    monday: true,
    tuesday: true,
    wednesday: false,
    thursday: false,
    friday: true,
    saturday: false,
    sunday: false 
  }
  
  def arb_parse( msg )
    
    NrCifParser::Record::BasicSchedule.parse( msg )
    
  end
  
  def record
    
    arb_parse( 'BSRG828851510191510231100100 POO2N75    113575825 DMUE   090      S            O' )
    
  end
  
  def test_invalid_message
    
    assert_raises( NrCifParser::RecordParserError ) do
    
      arb_parse( 'XX THIS SHOULD FAIL' )
    
    end
    
    assert_raises( NrCifParser::RecordParserError ) do
      
      arb_parse( 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' )
      
    end
    
  end
  
  def test_transaction_type
  
    assert_equal "R", record.type
  
  end
  
  def test_train_uid
  
    assert_equal "G82885", record.train_uid
  
  end
  
  def test_date_from
  
    assert_equal Date.new( 2015, 10, 19), record.date_from
  
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
    assert_equal "X", arb_parse( 'BSRG828851510191510231100100X' ).bank_holiday
  
    # assert_raises( NrCifParser::RecordParserError ) do
    # 
    #   NrCifParser::Record::BasicSchedule.parse( 'BSRG828851510191510231100100Q' )
    # 
    # end
  
  end
  
  def test_status
  
    assert_equal "P", record.status
  
  end
  
  def test_category
  
    assert_equal "OO", record.category
  
  end
  
  def test_identity
  
    assert_equal "2N75", record.identity
  
  end
  
  def test_headcode
  
    assert_nil record.headcode
  
  end
  
  def test_service_code
  
    assert_equal 13575825, record.service_code
  
  end
  
  def test_portion_id
  
    assert_nil record.portion_id
  
  end
  
  def test_power_type
  
    assert_equal "DMU", record.power_type
  
  end
  
  def test_timing_load
  
    assert_equal "E", record.timing_load
  
  end
  
  def test_speed
  
    assert_equal 90, record.speed
  
  end
  
  def test_operating_characteristics
  
    assert_nil record.op_character
  
  end
  
  def test_seating_class
  
    assert_equal "S", record.seating_class
  
  end
  
  def test_sleepers
  
    assert_nil record.sleepers
  
  end
  
  def test_reservations
  
    assert_nil record.reservations
  
  end
  
  def test_catering_code
  
    assert_nil record.catering_code
  
  end
  
  def test_service_brand
  
    assert_nil record.service_brand
  
  end
  
  def test_stp_indicator
  
    assert_equal "O", record.stp_indicator
  
  end
  
end
