class TestItem < ApplicationRecord
    belongs_to :apply_test
    belongs_to :question

    before_destroy :allow_destroy

    private

    def allow_destroy
        return if answer.blank?

        errors.add(:base, 'Questão já respondida.')
        throw(:abort)
    end

end
