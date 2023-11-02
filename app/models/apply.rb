class Apply < ApplicationRecord
  belongs_to :candidate
  belongs_to :recruiter
  has_many :apply_tests

  def create_apply_test(test_ids)
    tests = Test.where(id: test_ids)
    tests.each do |test|
      test_attributes = test.attributes.transform_keys{|key| key == 'id' ? "test_#{key}" : key }
      apply_tests.create(test_attributes.reject{|key| %w[can_copy created_at updated_at].include?(key) })
    end
  end
end
