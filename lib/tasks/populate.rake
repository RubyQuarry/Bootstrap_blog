namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    [Blog, Comment].each(&:delete_all)

     10.times do
      Blog.create!(
        author:    Faker::Name.name,
        title:     Faker::Lorem.word,
        content:   Faker::Lorem.paragraph(3),
        keywords: [Faker::Hacker.verb, "YOLO"],
        created_at: rand(2.year).ago,
        comments: Comment.all
      )

      Comment.create!(
        text:  Faker::Lorem.paragraph(3),
        name:  Faker::Name.name,
        blog:  Blog.first
      )
     end
    puts "blogs and comments created"
  end
end