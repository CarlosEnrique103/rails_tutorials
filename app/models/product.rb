# frozen_string_literal: true

class Product < ApplicationRecord
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :title, length: { minimum: 1,
                              maximum: 250,
                              too_short: 'debería tener al menos %<count>s caracter',
                              too_long: 'debería tener menos de %<count>s caracteres' }

  # %r{\.(gif|jpg|png)\z}i
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|png)/i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
end
