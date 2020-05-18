class Category < ApplicationRecord
  def self.generate_categories
    %w(식품/생활
    패션/뷰티
    가전/디지털
    여행/레저).each_with_index do |category_title, index|
      Category.create(title: category_title, position: index)
    end
  end
end
