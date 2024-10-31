puts "Seeding database..."
# Destroy all existing records

  puts "Cleaning database..."

  Charity.destroy_all
  User.destroy_all
  Category.destroy_all
  CharityProject.destroy_all
  Donation.destroy_all

  puts "Database cleaned."

# Create users

  puts "Creating users..."
  users = [{
    email: "post@david-dicke.de",
    password: "123456",
    first_name: "David",
    last_name: "Dicke",
    role: 2
    }, {
    email: "momoelgazzar@gmail.com",
    password: "123456",
    first_name: "Mohamed",
    last_name: "Elgazzar",
    role: 2
    }, {
    email: "pguelfi@gmail.com",
    password: "123456",
    first_name: "Pablo",
    last_name: "Guelfi",
    role: 2
    }]

  users.each do |user|
    User.create!(user)
    puts "User #{user[:email]} created."
  end

  puts "#{User.count} users created."

# Create charity cause categories

  puts "Creating categories..."
  categories = [
    "Climate Change",
    "Pollution",
    "Basic Needs",
    "Natural Disasters",
    "War",
    "Education",
    "Health",
    "Human Rights",
    "Famine",
    "Wildlife"
  ]
  categories.each do |category|
    Category.create!(name: category)
  end

  puts "#{Category.count} categories created."

# Create charities

  puts "Creating charities..."

  # db/seeds.rb

# db/seeds.rb

charities = [{
    name: "Save the Children",
    description: "Save the Children is a global non-profit organization that was founded in 1919. It is dedicated to improving the lives of children through better education, health care, and economic opportunities, as well as providing emergency aid in natural disasters, war, and other conflicts.",
    category: Category.find_by(name: "Basic Needs"),
    user: User.all.sample
  }, {
    name: "Oxfam",
    description: "Oxfam is a global organization that was founded in 1942. It is dedicated to fighting poverty and injustice around the world by providing emergency aid, promoting sustainable development, and advocating for social change.",
    category: Category.find_by(name: "Human Rights"),
    user: User.all.sample
  }, {
    name: "Greenpeace",
    description: "At Greenpeace we are honoured that our work is funded almost entirely by donations given to us by passionate individuals from all over the world who care about the planet and want to help us create change, and by grants from private foundations who share our values. Our independence is vital for us to be effective in our campaigning work, which is why we have it as a core principle that guides all of our fundraising. We do not accept funding from governments, corporations, political parties or intergovernmental organisations. We also screen all large private donations to identify if there is anything about them which could compromise our independence, our integrity or deflect from our campaign priorities. If we find something then we will refuse or return the donation.",
    category: Category.find_by(name: "Climate Change"),
    user: User.all.sample
  }]

charities.each do |charity_data|
  charity = Charity.create!(charity_data)  # Create the Charity instance
  puts "Charity #{charity.name} created."

  # Attach photos only to Greenpeace
  if charity.name == "Greenpeace"
    photo_path1 = Rails.root.join("db/seed-images/greenpeace/GP0STPOUA_8.webp")
    photo_path2 = Rails.root.join("db/seed-images/greenpeace/gp0stown2.webp")
    photo_path3 = Rails.root.join("db/seed-images/greenpeace/gp0stqdu4.webp")
    photo_path4 = Rails.root.join("db/seed-images/greenpeace/GP01CK9.webp")

    charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
    charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
    charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path3))
    charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path4))

    puts "Photos attached to #{charity.name}."
  end
end

  puts "#{Charity.count} charities created."

# Create charity projects

  puts "Creating charity projects..."

  charity_projects_oxfam = [{
      name: "Fighting Poverty in Africa",
      description: "Oxfam is working to fight poverty in Africa by providing clean water, food, and education to communities in need.",
      # A village in Niger named Bilma
      location: "Bilma, Niger",
      charity: Charity.find_by(name: "Oxfam")
    }, {
      name: "Emergency Aid in Yemen",
      description: "Oxfam is providing emergency aid in Yemen by delivering food, water, and medical supplies to families affected by the conflict.",
      # A village in Yemen named Al-Hudaydah
      location: "Al-Hudaydah, Yemen",
      charity: Charity.find_by(name: "Oxfam")
    }, {
      name: "Promoting Sustainable Development in India",
      description: "Oxfam is promoting sustainable development in India by supporting small-scale farmers",
      # A village in India named Khandwa
      location: "Khandwa, India",
      charity: Charity.find_by(name: "Oxfam")
    }
  ]

  charity_projects_greenpeace = [{
    name: "Protecting the Arctic",
    description: "Greenpeace is working to protect the Arctic by campaigning against oil drilling and industrial fishing in the region.",
    location: "Arctic Ocean",
    charity: Charity.find_by(name: "Greenpeace")
  }, {
    name: "Campaigning for Decarbonization in Brussels",
    description: "Greenpeace is campaigning for decarbonization in Brussels by promoting renewable energy and reducing greenhouse gas emissions.",
    location: "Brussels, Belgium",
    charity: Charity.find_by(name: "Greenpeace")
  }, {
    name: "Whale Conservation in the Pacific",
    description: "Greenpeace is working to protect whales in the Pacific by campaigning against commercial whaling and promoting marine conservation.",
    # pacific ocean near japan
    location: "Pacific Ocean",
    charity: Charity.find_by(name: "Greenpeace")
  }]

  charity_projects_save_the_children = [{
    name: "Providing Education in Afghanistan",
    description: "Save the Children is providing education in Afghanistan by building schools and training teachers in rural communities.",
    # a village in Afghanistan named Bamyan
    location: "Bamyan, Afghanistan",
    charity: Charity.find_by(name: "Save the Children")
  }, {
    name: "Emergency Aid in Syria",
    description: "Save the Children is providing emergency aid in Syria by delivering food, water, and medical supplies to families affected by the conflict.",
    # a village in Syria named Aleppo
    location: "Aleppo, Syria",
    charity: Charity.find_by(name: "Save the Children")
  }, {
    name: "Fighting Malnutrition in South Sudan",
    description: "Save the Children is fighting malnutrition in South Sudan by providing food, water, and medical care to children suffering from hunger.",
    # a village in South Sudan named Juba
    location: "Juba, South Sudan",
    charity: Charity.find_by(name: "Save the Children")
  }]

  charity_projects_all = charity_projects_oxfam + charity_projects_greenpeace + charity_projects_save_the_children

  charity_projects_all.each do |project|
    proj = CharityProject.create!(project)
    puts "Charity project #{ proj.name } created."
  end

  puts "#{CharityProject.count} charity projects created."

# Create donations

  puts "Creating donations..."

  20.times do
    Donation.create!(
      recurrent: [true, false].sample,
      amount: rand(5..10000),
      user: User.all.sample,
      charity_project: CharityProject.all.sample)
  end

  puts "#{Donation.count} donations created."

puts "Seeding complete!"
