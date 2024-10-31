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
    {
      name: "Climate Change",
      description: "Climate change addresses the critical issue of rising global temperatures and extreme weather events. Efforts in this category focus on reducing carbon emissions, promoting renewable energy, and fostering sustainable practices to mitigate the impact on ecosystems, protect vulnerable populations, and build resilience against future environmental challenges."
    },
    {
      name: "Pollution",
      description: "Pollution organizations tackle issues related to air, water, and soil contamination. They work on reducing industrial emissions, plastic waste, and other pollutants that threaten both human health and the environment, while advocating for cleaner production practices and stricter environmental regulations globally."
    },
    {
      name: "Basic Needs",
      description: "Organizations in this category focus on providing fundamental resources like clean water, food, shelter, and clothing to underserved populations. Addressing basic needs is essential for improving health outcomes, economic stability, and quality of life, especially in low-income communities and disaster-affected areas."
    },
    {
      name: "Natural Disasters",
      description: "Natural disaster relief organizations provide immediate aid and long-term recovery efforts for communities impacted by events like earthquakes, hurricanes, and floods. They focus on emergency response, disaster preparedness, and building resilience to reduce future vulnerabilities and support sustainable recovery in affected regions."
    },
    {
      name: "War",
      description: "War-focused organizations assist people affected by conflict, providing services like medical aid, shelter, and psychological support. These organizations also advocate for peacebuilding, refugee support, and human rights protection, aiming to create safer environments for those caught in or displaced by conflict."
    },
    {
      name: "Education",
      description: "Education organizations work to increase access to quality education globally, especially in underserved regions. They focus on literacy programs, vocational training, and school infrastructure to help individuals improve their skills, knowledge, and future opportunities, ultimately contributing to economic growth and social stability."
    },
    {
      name: "Health",
      description: "Health organizations focus on improving global health outcomes by providing medical services, disease prevention, and health education. Their work includes fighting infectious diseases, promoting mental health, and addressing healthcare disparities to ensure all people have access to essential health services."
    },
    {
      name: "Human Rights",
      description: "Human rights organizations protect and promote the rights and freedoms of individuals around the world. They work on issues like freedom of expression, equality, and protection against discrimination and violence, striving to build societies that respect the dignity and autonomy of all individuals."
    },
    {
      name: "Famine",
      description: "Famine relief organizations work to combat hunger and malnutrition, especially in regions affected by food scarcity and extreme poverty. These organizations provide food assistance, support sustainable agriculture, and promote policies to improve food security and prevent future hunger crises."
    },
    {
      name: "Wildlife",
      description: "Wildlife organizations focus on protecting endangered species and preserving biodiversity. They work to combat habitat loss, illegal poaching, and other threats to animals, while promoting conservation efforts and awareness to safeguard wildlife and maintain ecological balance for future generations."
    }
  ]
  categories.each do |category|
    Category.create!(name: category[:name], description: category[:description])
  end

  puts "#{Category.count} categories created."

# Create charities

  puts "Creating charities..."

  charities = [{
    name: "Save the Children",
    description: "Save the Children is a global non-profit organization that was founded in 1919. It is dedicated to improving the lives of children through better education, health care, and economic opportunities, as well as providing emergency aid in natural disasters, war, and other conflicts.",
    category: Category.find_by(name: "Basic Needs"),
    user: User.all.sample
  }, {
    name: "Oxfam",
    description: "Oxfam is a global organization that was founded in 1942. It is dedicated to fighting poverty and injustice around the world by providing emergency aid, promoting sustainable development, and advocating for social change.",
    category: Category.find_by(name: "Human Rights"),
    partner: "",
    user: User.all.sample
  }, {
    name: "Greenpeace",
    description: "Greenpeace is a global environmental organization that was founded in 1971. It is dedicated to promoting peace, protecting the environment, and preventing climate change through non-violent direct action, lobbying, and research.",
    category: Category.find_by(name: "Climate Change"),
    partner: "",
    user: User.all.sample
  },{
    name: "World Wildlife Fund (WWF)",
    description: "The World Wildlife Fund works globally to protect endangered species and preserve natural habitats, with a strong emphasis on combating climate change and promoting sustainability.",
    category: Category.find_by(name: "Climate Change"),
    partner: "",
    user: User.all.sample
  },
  {
    name: "The Sierra Club Foundation",
    description: "The Sierra Club Foundation works to advance climate solutions and promote green energy, sustainable practices, and environmental justice across communities.",
    category: Category.find_by(name: "Climate Change"),
    partner: "",
    user: User.all.sample
  },
  {
    name: "Friends of the Earth",
    description: "Friends of the Earth is an environmental advocacy organization that campaigns for sustainable policies and practices to combat the climate crisis, focusing on the well-being of communities and the environment.",
    category: Category.find_by(name: "Climate Change"),
    partner: "",
    user: User.all.sample
  },
  {
    name: "Rainforest Alliance",
    description: "The Rainforest Alliance works with local communities to protect biodiversity and fight climate change through sustainable agriculture and forestry initiatives.",
    category: Category.find_by(name: "Climate Change"),
    partner: "",
    user: User.all.sample
  },
  # Lesser-known charity with notable partners
  {
    name: "ClimateWorks Foundation",
    description: "ClimateWorks Foundation is a global platform that brings together partners to address the climate crisis through research, advocacy, and promoting sustainable practices. They partner with well-known organizations like the Hewlett Foundation and Bloomberg Philanthropies.",
    category: Category.find_by(name: "Climate Change"),
    partner: "Hewlett Foundation, Bloomberg Philanthropies",
    user: User.all.sample
  }
  ]

  charities.each do |charity|
    Charity.create!(charity)
    puts "Charity #{charity[:name]} created."
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
