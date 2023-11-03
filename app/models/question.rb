class Question < ApplicationRecord
  attr_accessor :alternatives

  QUESTION_TYPES = %w[alternative dissertative].freeze

  has_many :test_items

  before_validation :mount_alternatives, if: -> { question_type == 'alternative' }

  validates :body, :question_type, presence: true
  validates :question_type, inclusion: { in: QUESTION_TYPES, message: "deve estar em #{QUESTION_TYPES.join(', ')}" }

  private

  def correct_answer?
    answer = candidate_answer.description
    correct_answer = body.select{|key,value| key == 'right' }.values.last

    answer == correct_answer
  end

  # [{'text' => 'Italia'}, {'text' => 'Brasilia', 'right' => true}, {'text' => 'Mexico City'}]
  def mount_alternatives
    return [{}] if alternatives.blank?

    abc = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    formatted_body = alternatives.map.with_index do |alternative, index|
      current_alt = { abc[index] => alternative['text'] }
      current_alt.merge!(right: abc[index]) if alternative['right']
      current_alt
    end.inject(&:merge)

    self.body = formatted_body
  end
end
