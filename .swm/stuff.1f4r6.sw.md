---
id: 1f4r6
name: Stuff
file_version: 1.0.2
app_version: 0.7.1-1
file_blobs:
  app/models/question.rb: 1251efc12f3439fd4279ba5d60f0e7be145240d0
  app/models/answer.rb: 57debe1fc6f7d0191695395d8065aa14306b9e78
---

This is a question.
<!-- NOTE-swimm-snippet: the lines below link your snippet to Swimm -->
### 📄 app/models/question.rb
```ruby
⬜ 27     #  fk_rails_...  (user_id => users.id)
⬜ 28     #
⬜ 29     
🟩 30     class Question < ApplicationRecord
⬜ 31       include PgSearch::Model
⬜ 32       include CacheablePerUser
⬜ 33       include Answerable
```

<br/>

A class called `Answer`[<sup id="Z1InQ7H">↓</sup>](#f-Z1InQ7H)

It does stuff.

**Test**

*   a
    
*   b
    
*   c
<!-- NOTE-swimm-snippet: the lines below link your snippet to Swimm -->
### 📄 app/models/answer.rb
```ruby
⬜ 22     #  fk_rails_...  (user_id => users.id)
⬜ 23     #
⬜ 24     
🟩 25     class Answer < ApplicationRecord
⬜ 26       belongs_to :user
⬜ 27       belongs_to :question
⬜ 28     
```

<br/>

<!-- NOTE-swimm-snippet: the lines below link your snippet to Swimm -->
### 📄 app/models/answer.rb
```ruby
🟩 3      # == Schema Information
🟩 4      #
🟩 5      # Table name: answers
🟩 6      #
🟩 7      #  id          :bigint           not null, primary key
🟩 8      #  grade       :integer          default(0), not null
🟩 9      #  created_at  :datetime         not null
🟩 10     #  updated_at  :datetime         not null
🟩 11     #  question_id :bigint           not null
🟩 12     #  user_id     :bigint           not null
🟩 13     #
🟩 14     # Indexes
🟩 15     #
🟩 16     #  index_answers_on_question_id  (question_id)
🟩 17     #  index_answers_on_user_id      (user_id)
🟩 18     #
🟩 19     # Foreign Keys
🟩 20     #
🟩 21     #  fk_rails_...  (question_id => questions.id)
🟩 22     #  fk_rails_...  (user_id => users.id)
🟩 23     #
⬜ 24     
⬜ 25     class Answer < ApplicationRecord
⬜ 26       belongs_to :user
```

<br/>

<!-- THIS IS AN AUTOGENERATED SECTION. DO NOT EDIT THIS SECTION DIRECTLY -->
### Swimm Note

<span id="f-Z1InQ7H">Answer</span>[^](#Z1InQ7H) - "app/models/answer.rb" L25
```ruby
class Answer < ApplicationRecord
```

<br/>

This file was generated by Swimm. [Click here to view it in the app](https://app.swimm.io/repos/Z2l0aHViJTNBJTNBc3BhY2VkJTNBJTNBbGlwYW5za2k=/docs/1f4r6).