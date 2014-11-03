namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    [Blog, Comment, Admin].each(&:delete_all)

     10.times do
      b = Blog.create!(
        author:     Faker::Name.name,
        title:      Faker::Lorem.word,
        content:    "#Welcome \n You can use  __markdown language__ to make notes and share with classmates\n\n1. You can also create links.",
        keywords:   "runner,YOLO",
        created_at: rand(2.year).ago,
        published:  true
      )

      Comment.create!(
        text:       Faker::Lorem.paragraph(3),
        name:       Faker::Name.name,
        created_at: rand(2.year).ago,
        vote:       rand(10),
        blog:       b
      )
     end

    Admin.create!(:email => 'test@example.com', :password => 'password', :password_confirmation => 'password')

    puts "blogs and comments created"
  end
end