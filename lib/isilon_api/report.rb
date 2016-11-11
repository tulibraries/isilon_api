require 'json'
require 'spec_helper'
require 'csv'

module IsilonApi
  class Report

    @@isilon_total_size = 1.0E+15

    def initialize (log_output, units="MB")
      @units = units
      @log_output = log_output
      magnitude_table={"MB": 1_000_000,
                       "GB": 1_000_000_000,
                       "TB": 1_000_000_000_000,
                       "PB": 1_000_000_000_000_000}
      @scale_factor = magnitude_table[units]
      @report = Array.new
      @csv_file = CSV.open(@log_output, "wb")

      @conn = IsilonApi::Base.new.connection
      @isilon_conn = IsilonApi::Quotas.new @conn

      generate

    end

    def header
      quotas_header = [
        "name",
        "path",
        "usage (#{@units})",
        "free (#{@units})",
        "soft quota (#{@units})",
        "hard quota (#{@units})",
        "precentage used",
        "hard limit (%)"
      ]
      @csv_file << quotas_header
    end

    def self.to_array (quotas)
      quotas_array =  [quotas.name]
      quotas_array << quotas.path
      quotas_array << quotas.usage #/ @scale_factory
      quotas_array << quotas.free_space #/ @scale_factor
      quotas_array << quotas.soft_limit #/ @scale_factor
      quotas_array << quotas.hard_limit #/ @scale_factor
      quotas_array << quotas.percent_used
      quotas_array << Float(quotas.usage) / @@isilon_total_size

      return quotas_array
    end

    def generate
      header
      raw = JSON.parse(@isilon_conn.request_quotas.body)["quotas"]
      raw.each do |share_quota|
        quota = IsilonApi::Quota.new :quota => share_quota
        @csv_file << Report.to_array(quota)
      end
    end

  end
end
