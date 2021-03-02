class ShortLink < ApplicationRecord
  validates :original_url, presence: true, url: true

  before_create :generate_slug

  private

  def generate_slug
    self.slug ||= SecureRandom.hex(4)
  end
end
