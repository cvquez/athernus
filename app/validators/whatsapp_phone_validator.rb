# frozen_string_literal: true

# class WhatsappPhoneValidator < ActiveModel::Validator
class WhatsappPhoneValidator < ActiveModel::Validator
  def validate(record)
    clean_chars = record.send(:value).gsub(/\s/, '')
    return if clean_chars&.match(/^09.{8}$/) || clean_chars&.match(/^\+?5959.{8}$/)

    record.errors.add(:var, 'Formato de teléfono no válido')
  end
end
