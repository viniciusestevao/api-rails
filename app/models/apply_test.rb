class ApplyTest < ApplicationRecord
  belongs_to :apply, optional: true
  belongs_to :test
  has_many :test_items # , dependent: :restrict_with_error

  before_destroy :allow_destroy

  private

  def allow_destroy
    return if test_items.none?(&:answer) # return if test_items.none? { |test_item| test_item.answer }

    errors.add(:base, 'Questão já respondida.')
    throw(:abort)
  end
end
