namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do

    [Blog].each(&:delete_all)


     10.times do

      Blog.create(
      author: Faker::Name.name,
      title:  Faker::Lorem.word,
      content:Faker::Lorem.paragraph(3),
      tags:   Faker::Hacker.verb
      )
    end
  end
end