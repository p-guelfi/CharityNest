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
    #{
    #  name: "Pollution",
    #  description: "Pollution organizations tackle issues related to air, water, and soil contamination. They work on reducing industrial emissions, plastic waste, and other pollutants that threaten both human health and the environment, while advocating for cleaner production practices and stricter environmental regulations globally."
    #},
    {
      name: "Basic Needs",
      description: "Organizations in this category focus on providing fundamental resources like clean water, food, shelter, and clothing to underserved populations. Addressing basic needs is essential for improving health outcomes, economic stability, and quality of life, especially in low-income communities and disaster-affected areas."
    },
    {
      name: "Natural Disasters",
      description: "Natural disaster relief organizations provide immediate aid and long-term recovery efforts for communities impacted by events like earthquakes, hurricanes, and floods. They focus on emergency response, disaster preparedness, and building resilience to reduce future vulnerabilities and support sustainable recovery in affected regions."
    },
    #{
    #  name: "War",
    #  description: "War-focused organizations assist people affected by conflict, providing services like medical aid, shelter, and psychological support. These organizations also advocate for peacebuilding, refugee support, and human rights protection, aiming to create safer environments for those caught in or displaced by conflict."
    #},
    {
      name: "Education",
      description: "Education organizations work to increase access to quality education globally, especially in underserved regions. They focus on literacy programs, vocational training, and school infrastructure to help individuals improve their skills, knowledge, and future opportunities, ultimately contributing to economic growth and social stability."
    },
    {
      name: "Health",
      description: "Health organizations focus on improving global health outcomes by providing medical services, disease prevention, and health education. Their work includes fighting infectious diseases, promoting mental health, and addressing healthcare disparities to ensure all people have access to essential health services."
    },
    #{
    #  name: "Human Rights",
    #  description: "Human rights organizations protect and promote the rights and freedoms of individuals around the world. They work on issues like freedom of expression, equality, and protection against discrimination and violence, striving to build societies that respect the dignity and autonomy of all individuals."
    #},
    {
      name: "Famine",
      description: "Famine relief organizations work to combat hunger and malnutrition, especially in regions affected by food scarcity and extreme poverty. These organizations provide food assistance, support sustainable agriculture, and promote policies to improve food security and prevent future hunger crises."
    },
    #{
    #  name: "Wildlife",
    #  description: "Wildlife organizations focus on protecting endangered species and preserving biodiversity. They work to combat habitat loss, illegal poaching, and other threats to animals, while promoting conservation efforts and awareness to safeguard wildlife and maintain ecological balance for future generations."
    #}
  ]
  categories.each do |category|
    Category.create!(name: category[:name], description: category[:description])
  end

  puts "#{Category.count} categories created."

# Create charities

  puts "Creating charities..."

  # db/seeds.rb

# db/seeds.rb

charities = [{
    name: "Save the Children",
    description: "At Save the Children, we are deeply grateful for the unwavering support we receive from individuals and organizations around the world who are committed to improving the lives of children in need. Our work is predominantly funded through generous donations from passionate supporters, along with grants from philanthropic foundations that align with our mission. We firmly believe that our ability to serve vulnerable children and families hinges on our independence, which is why we adhere to strict principles in our fundraising efforts. We do not accept funding from sources that may compromise our values, including governmental bodies, corporations, and political entities. In order to safeguard our integrity and ensure that our programs remain focused on our mission, we rigorously evaluate all significant donations to confirm they do not conflict with our goals. Should any concerns arise during this review, we will take appropriate measures to refuse or return such contributions.",
    category: Category.find_by(name: "Basic Needs"),
    youtube_id: "bvF_w2bA6mc",
    user: User.all.sample
  }, {
    name: "Oxfam",
    description: "At Oxfam, we are immensely thankful for the support of individuals and organizations worldwide who stand with us in the fight against poverty and inequality. Our initiatives are primarily funded by the generous contributions of passionate supporters and grants from foundations that share our vision of a just world. Upholding our independence is essential for us to effectively carry out our mission, which is why we have established clear guidelines for our fundraising practices. We do not accept funding from governments, corporations, or political parties that may compromise our commitment to social justice. To maintain our integrity and ensure that all contributions align with our values, we carefully review all substantial donations. If any potential conflicts or issues arise, we are committed to refusing or returning those funds to protect the integrity of our work and the communities we serve.",
    category: Category.find_by(name: "Human Rights"),
    partner: "",
    youtube_id: "7Y0jQ7XwQo4",
    user: User.all.sample
  }, {
    name: "Greenpeace",
    description: "At Greenpeace we are honoured that our work is funded almost entirely by donations given to us by passionate individuals from all over the world who care about the planet and want to help us create change, and by grants from private foundations who share our values. Our independence is vital for us to be effective in our campaigning work, which is why we have it as a core principle that guides all of our fundraising. We do not accept funding from governments, corporations, political parties or intergovernmental organisations. We also screen all large private donations to identify if there is anything about them which could compromise our independence, our integrity or deflect from our campaign priorities. If we find something then we will refuse or return the donation.",
    category: Category.find_by(name: "Climate Change"),
    partner: "",
    youtube_id: "ccqlzIOGQio",
    user: User.all.sample
  },{
    name: "World Wildlife Fund (WWF)",
    description: "At the World Wildlife Fund (WWF), we are profoundly grateful for the dedicated support of individuals and organizations who share our commitment to conserving the planet's natural resources and protecting wildlife. Our work is primarily funded by generous donations from passionate supporters and grants from foundations that align with our conservation goals. Our independence is vital to the effectiveness of our initiatives, which is why we adhere to strict fundraising principles. We do not accept funding from governments, corporations, or political parties that could compromise our mission or influence our conservation priorities. To ensure that all donations align with our values, we conduct thorough reviews of significant contributions. Should any concerns arise regarding potential conflicts of interest, we are resolute in our commitment to refusing or returning such donations, ensuring that our efforts remain focused on our mission to create a sustainable future for wildlife and people alike.",
    category: Category.find_by(name: "Climate Change"),
    partner: "",
    youtube_id: "v-KqPiqYRck",
    user: User.all.sample
  },
  {
    name: "The Sierra Club Foundation",
    description: "At The Sierra Club Foundation, we are incredibly thankful for the support we receive from individuals and organizations dedicated to protecting the environment and promoting sustainable practices. Our initiatives are primarily funded through the generous donations of passionate supporters and grants from foundations that resonate with our mission of fostering a healthy planet. Upholding our independence is crucial to our effectiveness, which is why we strictly adhere to ethical fundraising principles. We do not accept funding from corporations, government entities, or political parties that may compromise our values or sway our advocacy efforts. To safeguard our integrity and ensure that all contributions align with our mission, we meticulously review significant donations. If any potential conflicts of interest arise during this process, we are committed to refusing or returning those funds, ensuring our work remains focused on environmental justice and sustainability for all.",
    category: Category.find_by(name: "Climate Change"),
    partner: "",
    youtube_id: "5V827rXIQU4",
    user: User.all.sample
  },
  {
    name: "Friends of the Earth",
    description: "At Friends of the Earth, we are profoundly grateful for the commitment and support of individuals and organizations around the globe who share our vision for a just and sustainable world. Our work is primarily funded by the generous donations of dedicated supporters and grants from foundations that align with our environmental advocacy. Maintaining our independence is vital for our effectiveness, which is why we adhere to strict fundraising standards. We do not accept funding from corporations, government bodies, or political parties that could compromise our mission or influence our campaigns. To ensure that every contribution reflects our values, we rigorously evaluate all significant donations. If any concerns arise regarding potential conflicts of interest, we pledge to refuse or return those funds, thereby safeguarding the integrity of our work and our commitment to environmental justice for all communities.",
    category: Category.find_by(name: "Climate Change"),
    partner: "",
    youtube_id: "QtM5l7gEoBk",
    user: User.all.sample
  },
  {
    name: "Rainforest Alliance",
    description: "At the Rainforest Alliance, we are deeply appreciative of the support from individuals and organizations worldwide who are committed to conserving biodiversity and promoting sustainable land use. Our efforts are primarily funded through the generous donations of passionate supporters and grants from foundations that share our mission of protecting ecosystems and improving livelihoods. We recognize that our independence is essential to the success of our initiatives, which is why we uphold stringent principles in our fundraising practices. We do not accept funding from corporations, governmental entities, or political parties that could compromise our integrity or sway our conservation goals. To ensure that all donations align with our values, we conduct thorough evaluations of significant contributions. If any potential conflicts arise, we are steadfast in our commitment to refusing or returning those funds, ensuring that our work remains focused on safeguarding the planet and empowering local communities.",
    category: Category.find_by(name: "Climate Change"),
    partner: "",
    youtube_id: "C5KqRYltFDs",
    user: User.all.sample
  },
  # Lesser-known charity with notable partners
  {
    name: "ClimateWorks Foundation",
    description: "At the ClimateWorks Foundation, we are immensely grateful for the support of individuals and organizations dedicated to combating climate change and promoting sustainable solutions. Our initiatives are primarily funded by the generous contributions of passionate supporters and grants from foundations that align with our mission to drive global climate action. We believe that our independence is essential for the effectiveness of our work, which is why we adhere to rigorous fundraising principles. We do not accept funding from corporations, government agencies, or political parties that may compromise our mission or influence our strategies. To ensure that all donations are in harmony with our values, we carefully assess all significant contributions. If any concerns about potential conflicts of interest arise during this review, we are committed to refusing or returning those funds, thereby safeguarding the integrity of our efforts to create a sustainable and equitable future for all.",
    category: Category.find_by(name: "Climate Change"),
    partner: "Hewlett Foundation, Bloomberg Philanthropies",
    youtube_id: "U9KP4iZIcuU",
    user: User.all.sample
  }
  ]

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
    charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
    charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

    puts "Photos attached to #{charity.name}."
  end
  if charity.name == "Save the Children"
    photo_path1 = Rails.root.join("db/seed-images/greenpeace/GP0STPOUA_8.webp")
    photo_path2 = Rails.root.join("db/seed-images/greenpeace/gp0stown2.webp")
    photo_path3 = Rails.root.join("db/seed-images/greenpeace/gp0stqdu4.webp")
    photo_path4 = Rails.root.join("db/seed-images/greenpeace/GP01CK9.webp")

    charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
    charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
    charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
    charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

    puts "Photos attached to #{charity.name}."
  end
  if charity.name == "Oxfam"
    photo_path1 = Rails.root.join("db/seed-images/greenpeace/GP0STPOUA_8.webp")
    photo_path2 = Rails.root.join("db/seed-images/greenpeace/gp0stown2.webp")
    photo_path3 = Rails.root.join("db/seed-images/greenpeace/gp0stqdu4.webp")
    photo_path4 = Rails.root.join("db/seed-images/greenpeace/GP01CK9.webp")

    charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
    charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
    charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
    charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

    puts "Photos attached to #{charity.name}."
  end
  if charity.name == "World Wildlife Fund (WWF)"
    photo_path1 = Rails.root.join("db/seed-images/greenpeace/GP0STPOUA_8.webp")
    photo_path2 = Rails.root.join("db/seed-images/greenpeace/gp0stown2.webp")
    photo_path3 = Rails.root.join("db/seed-images/greenpeace/gp0stqdu4.webp")
    photo_path4 = Rails.root.join("db/seed-images/greenpeace/GP01CK9.webp")

    charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
    charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
    charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
    charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

    puts "Photos attached to #{charity.name}."
  end
  if charity.name == "The Sierra Club Foundation"
    photo_path1 = Rails.root.join("db/seed-images/greenpeace/GP0STPOUA_8.webp")
    photo_path2 = Rails.root.join("db/seed-images/greenpeace/gp0stown2.webp")
    photo_path3 = Rails.root.join("db/seed-images/greenpeace/gp0stqdu4.webp")
    photo_path4 = Rails.root.join("db/seed-images/greenpeace/GP01CK9.webp")

    charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
    charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
    charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
    charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

    puts "Photos attached to #{charity.name}."
  end
  if charity.name == "Friends of the Earth"
    photo_path1 = Rails.root.join("db/seed-images/greenpeace/GP0STPOUA_8.webp")
    photo_path2 = Rails.root.join("db/seed-images/greenpeace/gp0stown2.webp")
    photo_path3 = Rails.root.join("db/seed-images/greenpeace/gp0stqdu4.webp")
    photo_path4 = Rails.root.join("db/seed-images/greenpeace/GP01CK9.webp")

    charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
    charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
    charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
    charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

    puts "Photos attached to #{charity.name}."
  end
  if charity.name == "Rainforest Alliance"
    photo_path1 = Rails.root.join("db/seed-images/greenpeace/GP0STPOUA_8.webp")
    photo_path2 = Rails.root.join("db/seed-images/greenpeace/gp0stown2.webp")
    photo_path3 = Rails.root.join("db/seed-images/greenpeace/gp0stqdu4.webp")
    photo_path4 = Rails.root.join("db/seed-images/greenpeace/GP01CK9.webp")

    charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
    charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
    charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
    charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

    puts "Photos attached to #{charity.name}."
  end
  if charity.name == "ClimateWorks Foundation"
    photo_path1 = Rails.root.join("db/seed-images/greenpeace/GP0STPOUA_8.webp")
    photo_path2 = Rails.root.join("db/seed-images/greenpeace/gp0stown2.webp")
    photo_path3 = Rails.root.join("db/seed-images/greenpeace/gp0stqdu4.webp")
    photo_path4 = Rails.root.join("db/seed-images/greenpeace/GP01CK9.webp")

    charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
    charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
    charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
    charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

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
      goal: 50000,
      charity: Charity.find_by(name: "Oxfam"),
      photos: [
      Rails.root.join("db/seed-images/greenpeace/GP01EFS-polar-bear-600x450-c-default.webp")
    ]
    }, {
      name: "Emergency Aid in Yemen",
      description: "Oxfam is providing emergency aid in Yemen by delivering food, water, and medical supplies to families affected by the conflict.",
      # A village in Yemen named Al-Hudaydah
      location: "Al-Hudaydah, Yemen",
      goal: 50000,
      charity: Charity.find_by(name: "Oxfam"),
      photos: [
      Rails.root.join("db/seed-images/greenpeace/030321_decarbonization.jpg")
    ]
    }, {
      name: "Promoting Sustainable Development in India",
      description: "Oxfam is promoting sustainable development in India by supporting small-scale farmers",
      # A village in India named Khandwa
      location: "Khandwa, India",
      goal: 50000,
      charity: Charity.find_by(name: "Oxfam"),
      photos: [
      Rails.root.join("db/seed-images/greenpeace/DSC_9026-1.jpg")
    ]
    }
  ]

  charity_projects_greenpeace = [{
    name: "Protecting the Arctic",
    description: "Greenpeace is working to protect the Arctic by campaigning against oil drilling and industrial fishing in the region.",
    location: "Arctic Ocean",
    goal: 50000,
    charity: Charity.find_by(name: "Greenpeace"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/GP01EFS-polar-bear-600x450-c-default.webp")
    ]
  }, {
    name: "Campaigning for Decarbonization in Brussels",
    description: "Greenpeace is campaigning for decarbonization in Brussels by promoting renewable energy and reducing greenhouse gas emissions.",
    location: "Brussels, Belgium",
    goal: 30000,
    charity: Charity.find_by(name: "Greenpeace"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/030321_decarbonization.jpg")
    ]
  }, {
    name: "Whale Conservation in the Pacific",
    description: "Greenpeace is working to protect whales in the Pacific by campaigning against commercial whaling and promoting marine conservation.",
    location: "Pacific Ocean",
    goal: 40000,
    charity: Charity.find_by(name: "Greenpeace"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/DSC_9026-1.jpg")
    ]
  }]


  charity_projects_save_the_children = [{
    name: "Providing Education in Afghanistan",
    description: "Save the Children is providing education in Afghanistan by building schools and training teachers in rural communities.",
    # a village in Afghanistan named Bamyan
    location: "Bamyan, Afghanistan",
    goal: 50000,
    charity: Charity.find_by(name: "Save the Children"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/DSC_9026-1.jpg")
    ]
  }, {
    name: "Emergency Aid in Syria",
    description: "Save the Children is providing emergency aid in Syria by delivering food, water, and medical supplies to families affected by the conflict.",
    # a village in Syria named Aleppo
    location: "Aleppo, Syria",
    goal: 50000,
    charity: Charity.find_by(name: "Save the Children"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/DSC_9026-1.jpg")
    ]
  }, {
    name: "Fighting Malnutrition in South Sudan",
    description: "Save the Children is fighting malnutrition in South Sudan by providing food, water, and medical care to children suffering from hunger.",
    # a village in South Sudan named Juba
    location: "Juba, South Sudan",
    goal: 50000,
    charity: Charity.find_by(name: "Save the Children"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/DSC_9026-1.jpg")
    ]
  }]

  charity_projects_wwf = [{
    name: "Protecting Endangered Species",
    description: "WWF is dedicated to protecting endangered species across the globe through conservation efforts and habitat protection.",
    # A wildlife reserve in Kenya named Maasai Mara
    location: "Maasai Mara, Kenya",
    goal: 80000,
    charity: Charity.find_by(name: "World Wildlife Fund (WWF)"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/GP01EFS-polar-bear-600x450-c-default.webp")
    ]
  }, {
    name: "Forest Conservation in the Amazon",
    description: "WWF is working to conserve the Amazon rainforest by promoting sustainable land practices and protecting native species.",
    # A rainforest area in Brazil named Manaus
    location: "Manaus, Brazil",
    goal: 100000,
    charity: Charity.find_by(name: "World Wildlife Fund (WWF)"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/030321_decarbonization.jpg")
    ]
  }, {
    name: "Marine Ecosystem Restoration",
    description: "WWF is focused on restoring marine ecosystems to protect ocean biodiversity and sustain coastal communities.",
    # A marine conservation area in Australia named Great Barrier Reef
    location: "Great Barrier Reef, Australia",
    goal: 90000,
    charity: Charity.find_by(name: "World Wildlife Fund (WWF)"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/DSC_9026-1.jpg")
    ]
  }
]

charity_projects_sierra_club = [{
    name: "Preserving National Parks",
    description: "The Sierra Club Foundation is dedicated to preserving America's national parks, ensuring these natural treasures are protected for future generations.",
    # A national park in the USA named Yosemite
    location: "Yosemite National Park, USA",
    goal: 85000,
    charity: Charity.find_by(name: "The Sierra Club Foundation"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/GP01EFS-polar-bear-600x450-c-default.webp")
    ]
  }, {
    name: "Clean Energy Transition",
    description: "The Sierra Club Foundation supports the transition to clean, renewable energy sources to combat climate change and reduce pollution.",
    # A city in the USA known for renewable energy initiatives named Austin
    location: "Austin, USA",
    goal: 95000,
    charity: Charity.find_by(name: "The Sierra Club Foundation"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/030321_decarbonization.jpg")
    ]
  }, {
    name: "Protecting Wildlife Habitats",
    description: "The Sierra Club Foundation works to protect wildlife habitats by advocating for sustainable land use and conservation policies.",
    # A wildlife habitat area in the USA named Yellowstone
    location: "Yellowstone National Park, USA",
    goal: 70000,
    charity: Charity.find_by(name: "The Sierra Club Foundation"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/DSC_9026-1.jpg")
    ]
  }
]

charity_projects_friends_of_the_earth = [{
    name: "Campaign for Clean Air",
    description: "Friends of the Earth is leading a campaign to improve air quality in urban areas by reducing pollution and promoting green energy solutions.",
    # A major urban area in the UK named London
    location: "London, UK",
    goal: 60000,
    charity: Charity.find_by(name: "Friends of the Earth"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/GP01EFS-polar-bear-600x450-c-default.webp")
    ]
  }, {
    name: "Protecting Pollinators",
    description: "Friends of the Earth is working to protect pollinators like bees by advocating against harmful pesticides and supporting organic farming.",
    # A region in the USA known for agriculture named California
    location: "California, USA",
    goal: 75000,
    charity: Charity.find_by(name: "Friends of the Earth"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/030321_decarbonization.jpg")
    ]
  }, {
    name: "Fighting Plastic Pollution",
    description: "Friends of the Earth is fighting plastic pollution by promoting sustainable alternatives and reducing single-use plastics.",
    # A coastal city in Australia named Sydney
    location: "Sydney, Australia",
    goal: 65000,
    charity: Charity.find_by(name: "Friends of the Earth"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/DSC_9026-1.jpg")
    ]
  }
]

charity_projects_rainforest_alliance = [{
    name: "Sustainable Farming in the Amazon",
    description: "The Rainforest Alliance promotes sustainable farming practices in the Amazon to protect biodiversity and support local communities.",
    # A rainforest area in Brazil named Acre
    location: "Acre, Brazil",
    goal: 90000,
    charity: Charity.find_by(name: "Rainforest Alliance"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/GP01EFS-polar-bear-600x450-c-default.webp")
    ]
  }, {
    name: "Forest Conservation in Central America",
    description: "The Rainforest Alliance works to conserve forests in Central America by advocating for sustainable land use and protecting wildlife.",
    # A conservation area in Guatemala named Petén
    location: "Petén, Guatemala",
    goal: 80000,
    charity: Charity.find_by(name: "Rainforest Alliance"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/030321_decarbonization.jpg")
    ]
  }, {
    name: "Protecting Indigenous Land Rights",
    description: "The Rainforest Alliance supports indigenous communities in protecting their land rights to preserve forests and traditional ways of life.",
    # An indigenous territory in Peru named Madre de Dios
    location: "Madre de Dios, Peru",
    goal: 85000,
    charity: Charity.find_by(name: "Rainforest Alliance"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/DSC_9026-1.jpg")
    ]
  }
]

charity_projects_climateworks = [{
    name: "Accelerating Clean Energy Solutions",
    description: "ClimateWorks Foundation is driving the transition to clean energy solutions worldwide to reduce carbon emissions and combat climate change.",
    # A major city known for clean energy efforts named San Francisco
    location: "San Francisco, USA",
    goal: 100000,
    charity: Charity.find_by(name: "ClimateWorks Foundation"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/GP01EFS-polar-bear-600x450-c-default.webp")
    ]
  }, {
    name: "Supporting Sustainable Urban Development",
    description: "ClimateWorks Foundation supports sustainable urban development initiatives to promote low-carbon, resilient cities.",
    # A city known for urban development initiatives named Copenhagen
    location: "Copenhagen, Denmark",
    goal: 120000,
    charity: Charity.find_by(name: "ClimateWorks Foundation"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/030321_decarbonization.jpg")
    ]
  }, {
    name: "Reducing Deforestation in Southeast Asia",
    description: "ClimateWorks Foundation is working to reduce deforestation in Southeast Asia by supporting sustainable land management practices.",
    # A tropical forest region in Indonesia named Borneo
    location: "Borneo, Indonesia",
    goal: 95000,
    charity: Charity.find_by(name: "ClimateWorks Foundation"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/DSC_9026-1.jpg")
    ]
  }
]

  charity_projects_all = charity_projects_oxfam + charity_projects_greenpeace + charity_projects_save_the_children + charity_projects_wwf + charity_projects_sierra_club + charity_projects_friends_of_the_earth + charity_projects_rainforest_alliance + charity_projects_climateworks

  charity_projects_all.each do |project|
    proj = CharityProject.create!(project.except(:photos))  # Create project without photos

    puts "Charity project #{proj.name} created."

    # Attach photos only if they exist for the project
    if project[:photos]
      project[:photos].each do |photo_path|
        proj.photos.attach(io: File.open(photo_path), filename: File.basename(photo_path))
      end

      puts "Photos attached to #{proj.name}."
    end
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
