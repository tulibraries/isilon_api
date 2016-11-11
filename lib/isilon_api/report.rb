require 'json'
require 'spec_helper'
require 'csv'
require 'stringio'

module IsilonApi
  module Report

    @@isilon_total_size = 1.0E+15

    def self.initialize (csv_filename, units=:mb)
      @units = units ? units : :mb 
      @csv_file = CSV.open(csv_filename, 'wb')

      magnitude_table={mb: 1.0E+6,
                       gb: 1.0E+9,
                       tb: 1.0E+12,
                       pb: 1.0E+15}
      @scale_factor = magnitude_table.include?(units) ? magnitude_table[units] : magnitude_table[:mb]

      @conn = IsilonApi::Base.new.connection
      @isilon_conn = IsilonApi::Quotas.new @conn
    end

    def self.header(csv_file)
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
      csv_file << quotas_header
    end

    def self.to_array (quotas, scale_factor)
      quotas_array =  [quotas.name]
      quotas_array << quotas.path
      quotas_array << quotas.usage #/ scale_factor
      quotas_array << quotas.free_space #/ scale_factor
      quotas_array << quotas.soft_limit #/ scale_factor
      quotas_array << quotas.hard_limit #/ scale_factor
      quotas_array << quotas.percent_used
      quotas_array << Float(quotas.usage) / @@isilon_total_size

      return quotas_array
    end

    def self.generate_csv(csv_filename, units=:mb)
      initialize(csv_filename, units)
      header(@csv_file)
      raw = JSON.parse(@isilon_conn.request_quotas.body)["quotas"]
      raw.each_with_index do |share_quota, i|
        quota = IsilonApi::Quota.new :quota => share_quota
        @csv_file << to_array(quota, @scale_factor)
      end
    end

  end
end
