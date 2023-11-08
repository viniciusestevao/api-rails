class Apply < ApplicationRecord
  belongs_to :candidate
  belongs_to :recruiter
  has_many :apply_tests, dependent: :restrict_with_error

  def create_apply_test(test_ids)
    tests = Test.where(id: test_ids)
    tests.each do |test|
      existing_apply_test = ApplyTest.find_by(test_id: test.id, apply_id: nil)
      
      if existing_apply_test
        # Atualize os campos do registro existente com os dados do teste
        existing_apply_test.update(test.attributes.reject { |key| %w[id can_copy created_at updated_at].include?(key) })
        # Atribua o id do novo apply ao registro existente
        existing_apply_test.update(apply_id: self.id)
        update_test_items(existing_apply_test)
      else
        debugger
        # Se não houver registro com apply_id nulo, crie um novo
        test_attributes = test.attributes.transform_keys { |key| key == 'id' ? "test_#{key}" : key }
        apply_test = apply_tests.create(test_attributes.reject { |key| %w[can_copy created_at updated_at].include?(key) })
        apply_test.update(apply_id: self.id)
        duplicate_test_items(apply_test)
      end
    end
  end
  
  def update_test_items(apply_test)
    test_items = apply_test.test_items
    test_items.each do |test_item|
      question = test_item.question
      test_item.update(question.attributes.except('id', 'tag', 'can_copy', 'created_at', 'updated_at', 'answer'))
    end
  end
  
  def duplicate_test_items(new_apply_test)
    debugger
    last_apply_test = ApplyTest.where(test_id: new_apply_test.test_id).where.not(id: new_apply_test.id).last
    if last_apply_test
      last_test_items = last_apply_test.test_items
      last_test_items.each do |last_test_item|
        question = last_test_item.question
        new_test_item = new_apply_test.test_items.create(question.attributes.except('id', 'tag', 'can_copy', 'created_at', 'updated_at', 'answer'))
        new_test_item.update(apply_test_id: new_apply_test.id)
      end
    end
  end
end
