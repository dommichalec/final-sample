# rails db:migrate:reset
# rails db:seed

User.create!(first_name: "Dom", last_name: "Michalec",
             email: "dominicjjmichalec@gmail.com", password: "password1",
             password_confirmation: "password1", admin: true)

100.times do |n|
  password = "password1"
  User.create!(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: "exampleuser#{n+1}@example.com",
              password: password,
              password_confirmation: password)

end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end
