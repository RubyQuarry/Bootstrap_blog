namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    [Blog, Comment, Admin].each(&:delete_all)

     10.times do
      b = Blog.create!(
        author:    Faker::Name.name,
        title:     Faker::Lorem.word,
        content:   "#Welcome \n You can use  __markdown language__ to make notes and share with classmates\n\n1. You can also create links.  Click [here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) to see a markdown cheat sheet \n2. You can make awesome code samples like this:\n\n```python\ns = 'Python syntax highlighting'\nprint s\n```\n You can also make awesome tables:\n\n| Tables        | Are           | Cool  |\n| ------------- |:-------------:| -----:|\n| col 3 is      | right-aligned | $1600 |\n| col 2 is      | centered      |   $12 |\n| zebra stripes | are neat      |    $1 |",
        keywords: "runner,YOLO",
        created_at: rand(2.year).ago,
        published: true
      )


      Comment.create!(
        text:  Faker::Lorem.paragraph(3),
        name:  Faker::Name.name,
        created_at: rand(2.year).ago,
        blog:  b
      )
     end

    Admin.create!(:email => 'test@example.com', :password => 'password', :password_confirmation => 'password')

    puts "blogs and comments created"
  end
end