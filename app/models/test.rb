class Test < ApplicationRecord
  has_many :apply_tests

  def create_test_items(question_ids)
    questions = Question.where(id: question_ids)
    
    questions.each do |question|
      question_attributes = question.attributes.transform_keys{|key| key == 'id' ? "question_#{key}" : key }
      TestItem.create(question_attributes.reject{|key| %w[can_copy id tag created_at updated_at].include?(key) })
    end
  end
end
