class ApplicationRecord < ActiveRecord::Base
  after_validation :log_errors
  include RansackableAttributes
  self.abstract_class = true

  def self.update_or_create_by(attributes = nil, &block)
    record = find_or_initialize_by(attributes)
    block.call(record) if block_given?
    record.save
    record
  end

  def self.to_csv
    attributes = column_names
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all&.each do |record|
        csv << attributes.map { |attr| record.send(attr) }
      end
    end
  end

  private

  def log_errors
    return if errors.empty?

    error_messages = errors.map { |e| "#{e.attribute}: #{e.message}" }.join(', ')
    Rails.logger.warn("Validation error: #{error_messages}")
  end
end
