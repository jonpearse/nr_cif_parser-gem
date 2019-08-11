module NrCifParser

  @@module_map = {}

  def self.register_record_type( record )

    @@module_map[ record.send( :code )] = record

  end

  class RecordParserError < StandardError; end

  module Record; end

end

require 'nr_cif_parser/parser'

# record stuff
require 'nr_cif_parser/record/base'
require 'nr_cif_parser/record/field_types'
require 'nr_cif_parser/record/mixins/running_days'

# Different record types
require 'nr_cif_parser/record/basic_schedule'
require 'nr_cif_parser/record/origin_location'
require 'nr_cif_parser/record/intermediate_location'
require 'nr_cif_parser/record/changes_en_route'
require 'nr_cif_parser/record/terminating_location'
