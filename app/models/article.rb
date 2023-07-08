# require 'transliteration'
require 'russian'
class Article < ApplicationRecord
  include Visible
  extend FriendlyId
  friendly_id :title, use: :slugged
  # before_validation :generate_slug
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  def normalize_friendly_id(input)
    text.to_slug.transliterate(:russian).normalize.to_s
  end

  # private

  # def generate_slug
  #   # self.slug = Transliteration.transliterate(title)
  #   self.slug = Russian.translit(title.parameterize)
  # end
end

