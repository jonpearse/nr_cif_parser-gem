module NrCifParser

  @@module_map = {}

  def self.register_record_type( record )

    @@module_map[ record.send( :code )] = record

  end

  class RecordParserError < StandardError; end

  module FieldTypes; end

  module Record;

    FT = NrCifParser::FieldTypes

  end

end

require 'nr_cif_parser/parser'

# record stuff
require 'nr_cif_parser/base_record'
require 'nr_cif_parser/field_types'
require 'nr_cif_parser/record/mixins/running_days'

# Different record types
require 'nr_cif_parser/record/header'
require 'nr_cif_parser/record/basic_schedule'
require 'nr_cif_parser/record/basic_schedule_extra_details'
require 'nr_cif_parser/record/origin_location'
require 'nr_cif_parser/record/intermediate_location'
require 'nr_cif_parser/record/changes_en_route'
require 'nr_cif_parser/record/terminating_location'
require 'nr_cif_parser/record/association'
require 'nr_cif_parser/record/tiploc_insert'
require 'nr_cif_parser/record/tiploc_amend'
require 'nr_cif_parser/record/tiploc_delete'
require 'nr_cif_parser/record/trailer'
