require 'test_helper'

class TestFieldTypes < MiniTest::Test

  # SETUP

  def should_fail( msg = nil )

    assert_raises( NrCifParser::RecordParserError, msg ){ yield }

  end

  # ACTUAL TESTS

  def test_string_types

    field = NrCifParser::FieldTypes::String

    assert_equal "Hello World", field.new( 16 ).parse( 'Hello World     ' )
    assert_nil field.new( 16, true ).parse( '       ' )
    assert_nil field.new( 16, true ).parse( '' )

    should_fail{ field.new( 16 ).parse( '' )}
    should_fail{ field.new( 16 ).parse( '     ' )}

  end

  def test_char_types

    field = NrCifParser::FieldTypes::Char

    assert_equal 'X', field.new.parse( 'X' )
    assert_nil field.new( true ).parse( '       ' )
    assert_nil field.new( true ).parse( '' )

    should_fail{ field.new.parse( '' )}
    should_fail{ field.new.parse( '     ' )}

  end

  def test_date_types

    compare = Date.new( 2019, 8, 16 )
    field = NrCifParser::FieldTypes::Date

    assert_equal compare, field.new.parse( '190816' )

    should_fail { field.new.parse( 'kjqwej' )}
    should_fail { field.new.parse( '190835' )}
    should_fail { field.new.parse( '' )}
    should_fail { field.new.parse( '   ' )}

  end

  def test_time_types

    field = NrCifParser::FieldTypes::Time

    assert_equal '12:00:00', field.new.parse( '1200' )
    assert_equal '12:00:30', field.new( true ).parse( '1200H' )
    assert_equal '12:00:00', field.new.parse( '1200H' )
    assert_nil field.new( false, true ).parse( '' )
    assert_nil field.new( false, true ).parse( '     ' )
    assert_nil field.new( true,  true ).parse( '' )
    assert_nil field.new( true,  true ).parse( '     ' )

    should_fail( 'Invalid hour' ){ field.new.parse( '2500' )}
    should_fail( 'Invalid minute' ){ field.new.parse( '1275' )}
    should_fail( 'Letters in input' ){ field.new.parse( 'XX48' )}

  end

  def test_bit_types

    field = NrCifParser::FieldTypes::Bit

    assert_equal 1,  field.new( 4 ).parse( '0001' ), '1'
    assert_equal 8,  field.new( 4 ).parse( '1000' ), '8'
    assert_equal 15, field.new( 4 ).parse( '1111' ), '15'

    should_fail( 'Whitespace' ){ assert_nil field.new( 4 ).parse( '     ' )}
    should_fail( 'Empty string' ){ field.new( 4 ).parse( '' )}
    should_fail( 'Garbage' ){ field.new( 4 ).parse( '04934A' )}

  end

  def test_enum_types

    field = NrCifParser::FieldTypes::Enum

    assert_equal 'A', field.new( %w{ A B C } ).parse( 'A' ), 'Exact match'
    assert_equal 'A', field.new( %w{ A B C } ).parse( 'A  ' ), 'Trailing space'
    assert_equal 'A', field.new( %w{ A B C } ).parse( '   A' ), 'Leading space'
    assert_equal 'A', field.new( %w{ A B C } ).parse( '   A    ' ), 'Lots of space'

    assert_equal 'A', field.new( %w{ A B C }, true ).parse( 'A' ), 'Exact match (nullable)'
    assert_equal 'A', field.new( %w{ A B C }, true ).parse( 'A  ' ), 'Trailing space (nullable)'
    assert_equal 'A', field.new( %w{ A B C }, true ).parse( '   A' ), 'Leading space (nullable)'
    assert_equal 'A', field.new( %w{ A B C }, true ).parse( '   A    ' ), 'Lots of space (nullable)'

    assert_nil field.new( %w{ A B C }, true ).parse( '' ), 'Empty string'
    assert_nil field.new( %w{ A B C }, true ).parse( '     ' ), 'Spaces'

    should_fail( 'Incorrect value' ){ field.new( %w{ A B C } ).parse( 'Z' )}
    should_fail( 'Missnig value' ){ field.new( %w{ A B C } ).parse( ' ' )}
    should_fail( 'Missnig value' ){ field.new( %w{ A B C } ).parse( '     ' )}

  end

  def test_number_types

    field = NrCifParser::FieldTypes::Number

    assert_equal 1,   field.new( 1 ).parse( '1' ), '1'
    assert_equal 100, field.new( 3 ).parse( '100' ), '100'
    assert_equal 45,  field.new( 3 ).parse( '045' ), '45 (leading zero)'

    assert_equal 0, field.new( 1 ).parse( ' ' ), 'Single space'
    assert_equal 0, field.new( 1 ).parse( '' ), 'Empty string'
    assert_nil field.new( 1, true ).parse( ' ' ), 'Single space'
    assert_nil field.new( 1, true ).parse( '' ), 'Empty string'

    should_fail( 'Single space (required)' ){ field.new( 1, true, true ).parse( ' ' )}
    should_fail( 'Empty string (required)' ){ field.new( 1, true, true ).parse( '' )}
    should_fail( 'Non-numeric input' ){ field.new( 1 ).parse( 'A' )}

  end

  def test_allowance_type

    field = NrCifParser::FieldTypes::Allowance

    assert_equal 5,   field.new.parse( '5' ), '5'
    assert_equal 5.5, field.new.parse( '5H' ), '5.5'
    assert_equal 94,  field.new.parse( '94' ), '94'
    assert_equal 0,   field.new.parse( '  ' ), 'Spaces'
    assert_equal 0,   field.new.parse( '' ), 'Empty string'

    should_fail( 'Non-numeric 1' ){ field.new.parse( 'X ' )}
    should_fail( 'Non-numeric 2' ){ field.new.parse( '9A' )}
    should_fail( 'Non-numeric 3' ){ field.new.parse( 'A' )}

  end

  def test_activity_type

    field = NrCifParser::FieldTypes::Activity

    assert_equal [], field.new.parse( '' ), 'Empty string'
    assert_equal [], field.new.parse( '  ' ), 'White space'
    assert_equal [], field.new.parse( '   ' ), 'Incorrect white space'

    assert_equal [ 'TF' ], field.new.parse( 'TF' ), 'Simple correct value'
    assert_equal [ 'TF' ], field.new.parse( '  TF' ), 'Leading space'
    assert_equal [ 'TF' ], field.new.parse( 'TF  ' ), 'Correct trailing space'
    assert_equal [ 'TF' ], field.new.parse( 'TF ' ), 'Incorrect trailing space'

    assert_equal [ 'TF', '-T' ], field.new.parse( 'TF-T' ), 'Multiple values'
    assert_equal [ 'TF', '-T' ], field.new.parse( 'TF  -T' ), 'Multiple values, spaced'
    assert_equal [ 'TF', '-T' ], field.new.parse( '  TF-T' ), 'Multiple values, leading space'
    assert_equal [ 'TF', '-T' ], field.new.parse( 'TF-T  ' ), 'Multiple values, trailing space'
    assert_equal [ 'TF', '-T' ], field.new.parse( '  TF-T  ' ), 'Multiple values, leading + trailing space'
    assert_equal [ 'TF', '-T' ], field.new.parse( '  TF  -T  ' ), 'Multiple values, leading, trailing, and internal space'

    assert_equal [ 'TF' ], field.new( 'TF' ).parse( 'TF' ), 'Simple correct value with requirement'
    assert_equal [ 'TF' ], field.new( 'TF' ).parse( '  TF' ), 'Leading space with requirement'
    assert_equal [ 'TF' ], field.new( 'TF' ).parse( 'TF  ' ), 'Correct trailing space with requirement'
    assert_equal [ 'TF' ], field.new( 'TF' ).parse( 'TF ' ), 'Incorrect trailing space with requirement'

    should_fail( 'Incorrect option' ){ field.new.parse( 'ZZ' )}
    should_fail( 'Incorrect option with others' ){ field.new.parse( 'ZZ-UW X ' )}
    should_fail( 'Missing requirement (empty)' ){ field.new( 'TF' ).parse( '' )}
    should_fail( 'Missing requirement (spaces)' ){ field.new( 'TF' ).parse( '  ' )}
    should_fail( 'Missing requirement (something else)' ){ field.new( 'TF' ).parse( 'PRR PM' )}

  end

end
