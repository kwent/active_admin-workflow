FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    body { "lorem ipsum" }
    category

    trait :reviewed do
      workflow_state { Post::REVIEWED }
    end

    trait :published do
      workflow_state { Post::PUBLISHED }
    end

    trait :archived do
      workflow_state { Post::ARCHIVED }
    end
  end
end
