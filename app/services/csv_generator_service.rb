require 'csv'
class CsvGeneratorService
  def initialize(records, fields: nil, **options)
    @records = records
    @options = options
    @fields = fields || default_fields
  end

  def call
    CSV.generate(**@options) do |csv|
      csv << @fields
      @records.each do |record|
        csv << record.attributes.values_at(*@fields)
      end
    end
  end

  def self.call(records, fields: nil, **options)
    new(records, fields: fields, **options).call
  end

  private

  def default_fields
    @records.first.class.column_names
  end
end
