class Interview < ApplicationRecord
  belongs_to :user
  has_many :videos, dependent: :destroy
  has_many :questions, dependent: :destroy
  validates :name, :company, presence: true

  def days_remaining
    Date.today - self.final_date.to_date
  end

  include PgSearch::Model
  pg_search_scope :search_by_name_and_date,
    against: [:name, :open_date, :final_date, :company],
    using: {
      tsearch: { prefix: true }
    }
end
