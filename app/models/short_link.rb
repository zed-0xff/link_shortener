class ShortLink < ApplicationRecord
  before_create :generate_slug

  private

  def generate_slug
    self.slug ||= SecureRandom.hex(4)
  end
end
