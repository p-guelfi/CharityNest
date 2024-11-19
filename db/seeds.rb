require 'open-uri'
require 'nokogiri'
require 'json'

puts "Seeding database..."
# Destroy all existing records

  puts "Cleaning database..."

  Comment.destroy_all
  Discussion.destroy_all
  Charity.destroy_all
  User.destroy_all
  Category.destroy_all
  CharityProject.destroy_all
  Donation.destroy_all
  #Report.destroy_all

  puts "Database cleaned."

# Create users
  def create_users
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
      }, {
      email: "max@richkid.com",
      password: "123456",
      first_name: "Max",
      last_name: "Ranoldi",
      role: 1
      }, {
      email: "master@evaluator.com",
      password: "123456",
      first_name: "Robert",
      last_name: "Thoughtful",
      role: 3
      }
    ]

    users.each do |user|
      User.create!(user)
      puts "User #{user[:email]} created."
    end

    puts "#{User.count} users created."
  end

  create_users

# Create charity cause categories
  def create_categories
    puts "Creating categories..."
    categories = [
      {
        name: "Climate Change",
        description: "Climate change addresses the critical issue of rising global temperatures and extreme weather events. Efforts in this category focus on reducing carbon emissions, promoting renewable energy, and fostering sustainable practices to mitigate the impact on ecosystems, protect vulnerable populations, and build resilience against future environmental challenges."
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
        name: "Education",
        description: "Education organizations work to increase access to quality education globally, especially in underserved regions. They focus on literacy programs, vocational training, and school infrastructure to help individuals improve their skills, knowledge, and future opportunities, ultimately contributing to economic growth and social stability."
      },
      {
        name: "Health",
        description: "Health organizations focus on improving global health outcomes by providing medical services, disease prevention, and health education. Their work includes fighting infectious diseases, promoting mental health, and addressing healthcare disparities to ensure all people have access to essential health services."
      },
      {
        name: "Famine",
        description: "Famine relief organizations work to combat hunger and malnutrition, especially in regions affected by food scarcity and extreme poverty. These organizations provide food assistance, support sustainable agriculture, and promote policies to improve food security and prevent future hunger crises."
      },
      #{
      #  name: "War",
      #  description: "War-focused organizations assist people affected by conflict, providing services like medical aid, shelter, and psychological support. These organizations also advocate for peacebuilding, refugee support, and human rights protection, aiming to create safer environments for those caught in or displaced by conflict."
      #},
      #{
      #  name: "Human Rights",
      #  description: "Human rights organizations protect and promote the rights and freedoms of individuals around the world. They work on issues like freedom of expression, equality, and protection against discrimination and violence, striving to build societies that respect the dignity and autonomy of all individuals."
      #},
      #{
      #  name: "Pollution",
      #  description: "Pollution organizations tackle issues related to air, water, and soil contamination. They work on reducing industrial emissions, plastic waste, and other pollutants that threaten both human health and the environment, while advocating for cleaner production practices and stricter environmental regulations globally."
      #},
      #{
      #  name: "Wildlife",
      #  description: "Wildlife organizations focus on protecting endangered species and preserving biodiversity. They work to combat habitat loss, illegal poaching, and other threats to animals, while promoting conservation efforts and awareness to safeguard wildlife and maintain ecological balance for future generations."
      #}
    ]
    categories.each do |category|
      Category.create!(name: category[:name], description: category[:description])
    end

    puts "#{Category.count} categories created."
  end

  create_categories

# Create charities
  def create_charities
    puts "Creating charities..."

    charities = [{
      name: "Save the Children",
      # Add a brief description of the charity with 35 words
      teaser: "Save the Children is dedicated to improving the lives of children worldwide by providing essential resources, education, and healthcare. Join us in supporting vulnerable communities and creating a brighter future for children in need.",
      description: "At Save the Children, we are deeply grateful for the unwavering support we receive from individuals and organizations around the world who are committed to improving the lives of children in need. Our work is predominantly funded through generous donations from passionate supporters, along with grants from philanthropic foundations that align with our mission. We firmly believe that our ability to serve vulnerable children and families hinges on our independence, which is why we adhere to strict principles in our fundraising efforts. We do not accept funding from sources that may compromise our values, including governmental bodies, corporations, and political entities. In order to safeguard our integrity and ensure that our programs remain focused on our mission, we rigorously evaluate all significant donations to confirm they do not conflict with our goals. Should any concerns arise during this review, we will take appropriate measures to refuse or return such contributions.",
      category: Category.find_by(name: "Basic Needs"),
      youtube_id: "bvF_w2bA6mc",
      user: User.all.sample
    }, {
    # A charity organisation for category Health
      name: "Doctors Without Borders",
      # Add a brief description of the charity with 35 words
      teaser: "Doctors Without Borders provides medical care to communities affected by conflict, epidemics, and natural disasters worldwide. Join us in delivering emergency aid and lifesaving treatment to those in need.",
      description: "At Doctors Without Borders, we are deeply grateful for the support of individuals and organizations who share our commitment to providing medical care to communities affected by conflict, epidemics, and natural disasters worldwide. Our work is primarily funded by the generous contributions of passionate supporters and grants from foundations that align with our mission of delivering emergency aid and lifesaving treatment to those in need. Upholding our independence is essential for the effectiveness of our initiatives, which is why we adhere to strict fundraising principles. We do not accept funding from governments, corporations, or political parties that may compromise our ability to provide impartial medical care. To ensure that all donations align with our values, we carefully review all significant contributions. If any potential conflicts of interest arise, we are resolute in our commitment to refusing or returning those funds to protect the integrity of our medical programs and the communities we serve.",
      category: Category.find_by(name: "Health"),
      partner: "",
      youtube_id: "f6qxuqw7Kwk",
      user: User.all.sample
    }, {
      # A charity organisation for category Education
      name: "UNICEF",
      # Add a brief description of the charity with 35 words
      teaser: "UNICEF is dedicated to protecting the rights of children and providing education, healthcare, and protection services worldwide. Join us in advocating for children's well-being and building a brighter future.",
      description: "At UNICEF, we are profoundly grateful for the support of individuals and organizations who share our commitment to protecting the rights of children and providing education, healthcare, and protection services worldwide. Our work is primarily funded by the generous contributions of passionate supporters and grants from foundations that align with our mission of advocating for children's well-being and building a brighter future. Upholding our independence is essential for the effectiveness of our initiatives, which is why we adhere to strict fundraising principles. We do not accept funding from governments, corporations, or political parties that may compromise our ability to advocate for children's rights. To ensure that all donations align with our values, we carefully review all significant contributions. If any potential conflicts of interest arise, we are resolute in our commitment to refusing or returning those funds to protect the integrity of our programs and the children we serve.",
      category: Category.find_by(name: "Education"),
      partner: "",
      youtube_id: "NL5Mqoy1jtE",
      user: User.all.sample
    }, {
      # A charity organisation for category Natural Disasters
      name: "Red Cross",
      # Add a brief description of the charity with 35 words
      teaser: "The Red Cross provides emergency relief and disaster response to communities affected by crises worldwide. Join us in delivering aid, healthcare, and support to those in need during challenging times.",
      description: "At the Red Cross, we are deeply grateful for the support of individuals and organizations who share our commitment to providing emergency relief and disaster response to communities affected by crises worldwide. Our work is primarily funded by the generous contributions of passionate supporters and grants from foundations that align with our mission of delivering aid, healthcare, and support to those in need during challenging times. Upholding our independence is essential for the effectiveness of our initiatives, which is why we adhere to strict fundraising principles. We do not accept funding from governments, corporations, or political parties that may compromise our ability to provide impartial humanitarian assistance. To ensure that all donations align with our values, we carefully review all significant contributions. If any potential conflicts of interest arise, we are resolute in our commitment
      to refusing or returning those funds to protect the integrity of our programs and the communities we serve.",
      category: Category.find_by(name: "Natural Disasters"),
      partner: "",
      youtube_id: "Hei4pIl_Tr0",
      user: User.all.sample
    }, {
      name: "Oxfam",
      # Add a brief description of the charity with 35 words
      teaser: "Oxfam is dedicated to fighting poverty and injustice worldwide. Our programs focus on providing essential resources, advocating for social change, and empowering communities to create a more equitable world.",
      description: "At Oxfam, we are immensely thankful for the support of individuals and organizations worldwide who stand with us in the fight against poverty and inequality. Our initiatives are primarily funded by the generous contributions of passionate supporters and grants from foundations that share our vision of a just world. Upholding our independence is essential for us to effectively carry out our mission, which is why we have established clear guidelines for our fundraising practices. We do not accept funding from governments, corporations, or political parties that may compromise our commitment to social justice. To maintain our integrity and ensure that all contributions align with our values, we carefully review all substantial donations. If any potential conflicts or issues arise, we are committed to refusing or returning those funds to protect the integrity of our work and the communities we serve.",
      category: Category.find_by(name: "Famine"),
      partner: "",
      youtube_id: "7Y0jQ7XwQo4",
      user: User.all.sample
    }, {
      name: "Greenpeace",
      # Add a brief description of the charity with 35 words
      teaser: "Greenpeace is dedicated to protecting the environment and promoting sustainable practices worldwide. Join us in advocating for climate action, biodiversity conservation, and a greener future for our planet.",
      description: "At Greenpeace we are honoured that our work is funded almost entirely by donations given to us by passionate individuals from all over the world who care about the planet and want to help us create change, and by grants from private foundations who share our values. Our independence is vital for us to be effective in our campaigning work, which is why we have it as a core principle that guides all of our fundraising. We do not accept funding from governments, corporations, political parties or intergovernmental organisations. We also screen all large private donations to identify if there is anything about them which could compromise our independence, our integrity or deflect from our campaign priorities. If we find something then we will refuse or return the donation.",
      category: Category.find_by(name: "Climate Change"),
      partner: "",
      youtube_id: "ccqlzIOGQio",
      user: User.all.sample
    },{
      name: "World Wildlife Fund (WWF)",
      # Add a brief description of the charity with 35 words avoiding the phrase "is dedicated"
      teaser: "The World Wildlife Fund (WWF) is grateful for the support of individuals and organizations who share our commitment to conserving the planet's natural resources and protecting wildlife.",
      description: "At the World Wildlife Fund (WWF), we are profoundly grateful for the dedicated support of individuals and organizations who share our commitment to conserving the planet's natural resources and protecting wildlife. Our work is primarily funded by generous donations from passionate supporters and grants from foundations that align with our conservation goals. Our independence is vital to the effectiveness of our initiatives, which is why we adhere to strict fundraising principles. We do not accept funding from governments, corporations, or political parties that could compromise our mission or influence our conservation priorities. To ensure that all donations align with our values, we conduct thorough reviews of significant contributions. Should any concerns arise regarding potential conflicts of interest, we are resolute in our commitment to refusing or returning such donations, ensuring that our efforts remain focused on our mission to create a sustainable future for wildlife and people alike.",
      category: Category.find_by(name: "Climate Change"),
      partner: "",
      youtube_id: "v-KqPiqYRck",
      user: User.all.sample
    },
    {
      name: "The Sierra Club Foundation",
      # Add a brief description of the charity with 35 words varying in pharsing style from the above teasers
      teaser: "The Sierra Club Foundation is grateful for the support of individuals and organizations dedicated to protecting the environment and promoting sustainable practices. Join us in fostering a healthy planet.",
      description: "At The Sierra Club Foundation, we are incredibly thankful for the support we receive from individuals and organizations dedicated to protecting the environment and promoting sustainable practices. Our initiatives are primarily funded through the generous donations of passionate supporters and grants from foundations that resonate with our mission of fostering a healthy planet. Upholding our independence is crucial to our effectiveness, which is why we strictly adhere to ethical fundraising principles. We do not accept funding from corporations, government entities, or political parties that may compromise our values or sway our advocacy efforts. To safeguard our integrity and ensure that all contributions align with our mission, we meticulously review significant donations. If any potential conflicts of interest arise during this process, we are committed to refusing or returning those funds, ensuring our work remains focused on environmental justice and sustainability for all.",
      category: Category.find_by(name: "Climate Change"),
      partner: "",
      youtube_id: "5V827rXIQU4",
      user: User.all.sample
    },
    {
      name: "Friends of the Earth",
      # Add a brief description of the charity with 35 words varying in pharsing style from the above teasers
      teaser: "Friends of the Earth is profoundly grateful for the commitment and support of individuals and organizations who share our vision for a just and sustainable world. Join us in advocating for environmental justice.",
      description: "At Friends of the Earth, we are profoundly grateful for the commitment and support of individuals and organizations around the globe who share our vision for a just and sustainable world. Our work is primarily funded by the generous donations of dedicated supporters and grants from foundations that align with our environmental advocacy. Maintaining our independence is vital for our effectiveness, which is why we adhere to strict fundraising standards. We do not accept funding from corporations, government bodies, or political parties that could compromise our mission or influence our campaigns. To ensure that every contribution reflects our values, we rigorously evaluate all significant donations. If any concerns arise regarding potential conflicts of interest, we pledge to refuse or return those funds, thereby safeguarding the integrity of our work and our commitment to environmental justice for all communities.",
      category: Category.find_by(name: "Climate Change"),
      partner: "",
      youtube_id: "QtM5l7gEoBk",
      user: User.all.sample
    },
    {
      name: "Rainforest Alliance",
      # Add a brief description of the charity with 35 words varying in pharsing style from the above teasers
      teaser: "The Rainforest Alliance is deeply appreciative of the support from individuals and organizations worldwide who are committed to conserving biodiversity and promoting sustainable land use. Join us in safeguarding ecosystems.",
      description: "At the Rainforest Alliance, we are deeply appreciative of the support from individuals and organizations worldwide who are committed to conserving biodiversity and promoting sustainable land use. Our efforts are primarily funded through the generous donations of passionate supporters and grants from foundations that share our mission of protecting ecosystems and improving livelihoods. We recognize that our independence is essential to the success of our initiatives, which is why we uphold stringent principles in our fundraising practices. We do not accept funding from corporations, governmental entities, or political parties that could compromise our integrity or sway our conservation goals. To ensure that all donations align with our values, we conduct thorough evaluations of significant contributions. If any potential conflicts arise, we are steadfast in our commitment to refusing or returning those funds, ensuring that our work remains focused on safeguarding the planet and empowering local communities.",
      category: Category.find_by(name: "Climate Change"),
      partner: "",
      youtube_id: "C5KqRYltFDs",
      user: User.all.sample
    },
    # Lesser-known charity with notable partners
    {
      name: "ClimateWorks Foundation",
      # Add a brief description of the charity with 50 words varying in pharsing style from the above teasers
      teaser: "The ClimateWorks Foundation is immensely grateful for the support of individuals and organizations dedicated to combating climate change and promoting sustainable solutions. Join us in driving global climate action.",
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
        photo_path1 = Rails.root.join("db/seed-images/save-the-children/save-the-children.avif")
        photo_path2 = Rails.root.join("db/seed-images/save-the-children/sudan.avif")
        photo_path3 = Rails.root.join("db/seed-images/save-the-children/save-the-children.avif")
        photo_path4 = Rails.root.join("db/seed-images/save-the-children/share-ideas.avif")

        charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
        charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
        charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
        charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

        puts "Photos attached to #{charity.name}."
      end
      if charity.name == "Oxfam"
        photo_path1 = Rails.root.join("db/seed-images/oxfam/oxfam.webp")
        photo_path2 = Rails.root.join("db/seed-images/oxfam/povafrica.avif")
        photo_path3 = Rails.root.join("db/seed-images/oxfam/oxfam.webp")
        photo_path4 = Rails.root.join("db/seed-images/save-the-children/share-ideas.avif")

        charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
        charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
        charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
        charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

        puts "Photos attached to #{charity.name}."
      end
      if charity.name == "World Wildlife Fund (WWF)"
        photo_path1 = Rails.root.join("db/seed-images/wwf/wwf.png")
        photo_path2 = Rails.root.join("db/seed-images/wwf/endangered.avif")
        photo_path3 = Rails.root.join("db/seed-images/wwf/wwf.png")
        photo_path4 = Rails.root.join("db/seed-images/save-the-children/share-ideas.avif")

        charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
        charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
        charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
        charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

        puts "Photos attached to #{charity.name}."
      end
      if charity.name == "The Sierra Club Foundation"
        photo_path1 = Rails.root.join("db/seed-images/sierra-club/sierra-club.jpg")
        photo_path2 = Rails.root.join("db/seed-images/sierra-club/habitats.avif")
        photo_path3 = Rails.root.join("db/seed-images/sierra-club/sierra-club.jpg")
        photo_path4 = Rails.root.join("db/seed-images/save-the-children/share-ideas.avif")

        charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
        charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
        charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
        charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

        puts "Photos attached to #{charity.name}."
      end
      if charity.name == "Friends of the Earth"
        photo_path1 = Rails.root.join("db/seed-images/friends-of-earth/banner.png")
        photo_path2 = Rails.root.join("db/seed-images/friends-of-earth/friends-of-earth-support-project.webp")
        photo_path3 = Rails.root.join("db/seed-images/friends-of-earth/friends-support-charity.avif")
        photo_path4 = Rails.root.join("db/seed-images/friends-of-earth/friends-of-earth-ideas.avif")

        charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
        charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
        charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
        charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

        puts "Photos attached to #{charity.name}."
      end
      if charity.name == "Rainforest Alliance"
        photo_path1 = Rails.root.join("db/seed-images/rainforest-alliance/rainforest-alliance.avif")
        photo_path2 = Rails.root.join("db/seed-images/rainforest-alliance/indigenous.avif")
        photo_path3 = Rails.root.join("db/seed-images/rainforest-alliance/rainforest-alliance.avif")
        photo_path4 = Rails.root.join("db/seed-images/save-the-children/share-ideas.avif")

        charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
        charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
        charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
        charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

        puts "Photos attached to #{charity.name}."
      end
      if charity.name == "ClimateWorks Foundation"
        photo_path1 = Rails.root.join("db/seed-images/climateworks/climate-works.avif")
        photo_path2 = Rails.root.join("db/seed-images/climateworks/clean-ener-solutions.avif")
        photo_path3 = Rails.root.join("db/seed-images/climateworks/climate-works.avif")
        photo_path4 = Rails.root.join("db/seed-images/save-the-children/share-ideas.avif")

        charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
        charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
        charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
        charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

        puts "Photos attached to #{charity.name}."
      end
      if charity.name == "Doctors Without Borders"
        photo_path1 = Rails.root.join("db/seed-images/doctors-without-borders/doctors-without-borders.jpg")
        photo_path2 = Rails.root.join("db/seed-images/doctors-without-borders/medical-yemen.jpg")
        photo_path3 = Rails.root.join("db/seed-images/doctors-without-borders/doctors-without-borders.jpg")
        photo_path4 = Rails.root.join("db/seed-images/save-the-children/share-ideas.avif")

        charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
        charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
        charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
        charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

        puts "Photos attached to #{charity.name}."
      end
      if charity.name == "UNICEF"
        photo_path1 = Rails.root.join("db/seed-images/unicef/unicef.jpeg")
        photo_path2 = Rails.root.join("db/seed-images/unicef/nutrition-sudan.jpg")
        photo_path3 = Rails.root.join("db/seed-images/unicef/unicef.jpeg")
        photo_path4 = Rails.root.join("db/seed-images/save-the-children/share-ideas.avif")

        charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
        charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
        charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
        charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

        puts "Photos attached to #{charity.name}."
      end
      if charity.name == "Red Cross"
        photo_path1 = Rails.root.join("db/seed-images/red-cross/red-cross.webp")
        photo_path2 = Rails.root.join("db/seed-images/red-cross/healthcare-yemen.webp")
        photo_path3 = Rails.root.join("db/seed-images/red-cross/red-cross.webp")
        photo_path4 = Rails.root.join("db/seed-images/save-the-children/share-ideas.avif")

        charity.photos.attach(io: File.open(photo_path1), filename: File.basename(photo_path1))
        charity.photos.attach(io: File.open(photo_path2), filename: File.basename(photo_path2))
        charity.photos.attach(io: File.open(photo_path3), filename: File.basename(photo_path3))
        charity.photos.attach(io: File.open(photo_path4), filename: File.basename(photo_path4))

        puts "Photos attached to #{charity.name}."
      end
    end

    puts "#{Charity.count} charities created."
  end

  create_charities

# Create charity projects

  def create_charity_projects
    puts "Creating charity projects..."

    charity_projects_oxfam = [{
      name: "Oxfam",  # This is now the first project
      description: "This project directly funds Oxfam, helping to support its core mission of fighting poverty and inequality around the world.",
      location: "Nairobi, Kenya",
      goal: 50000,
      charity: Charity.find_by(name: "Oxfam"),
      photos: [
        Rails.root.join("db/seed-images/oxfam/oxfam.webp")
      ]
    }, {
      name: "Fighting Poverty in Africa",
      description: "Oxfam is working to fight poverty in Africa by providing clean water, food, and education to communities in need.",
      # A village in Niger named Bilma
      location: "Bilma, Niger",
      goal: 50000,
      charity: Charity.find_by(name: "Oxfam"),
      photos: [
        Rails.root.join("db/seed-images/oxfam/povafrica.avif")
      ]
    }, {
      name: "Emergency Aid in Yemen",
      description: "Oxfam is providing emergency aid in Yemen by delivering food, water, and medical supplies to families affected by the conflict.",
      # A village in Yemen named Al-Hudaydah
      location: "Al-Hudaydah, Yemen",
      goal: 50000,
      charity: Charity.find_by(name: "Oxfam"),
      photos: [
        Rails.root.join("db/seed-images/oxfam/yemen.jpg")
      ]
    }, {
      name: "Promoting Sustainable Development in India",
      description: "Oxfam is promoting sustainable development in India by supporting small-scale farmers.",
      # A village in India named Khandwa
      location: "Khandwa, India",
      goal: 50000,
      charity: Charity.find_by(name: "Oxfam"),
      photos: [
        Rails.root.join("db/seed-images/oxfam/sus-india.avif")
      ]
    }
    ]

    charity_projects_greenpeace = [{
        name: "Greenpeace",  # This is now the first project
        description: "This project directly funds Greenpeace, helping to support its core mission of protecting the environment and promoting peace worldwide.",
        location: "Amsterdam, Netherlands",
        goal: 50000,
        charity: Charity.find_by(name: "Greenpeace"),
        photos: [
          Rails.root.join("db/seed-images/greenpeace/GP0STPOUA_8.webp")
        ]
      }, {
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
      }
    ]

    charity_projects_save_the_children = [{
        name: "Save the Children",  # Replace this with the actual title of the new project
        description: "This project directly funds Save the Children, helping to support its mission of protecting and empowering vulnerable children worldwide.",
        location: "London, United Kingdom",  # Specify the location
        goal: 50000,  # Set a funding goal
        charity: Charity.find_by(name: "Save the Children"),  # Link to the charity
        photos: [
          Rails.root.join("db/seed-images/save-the-children/save-the-children.avif")  # Path to an image related to the new project
        ]
      }, {
        name: "Providing Education in Afghanistan",
        description: "Save the Children is providing education in Afghanistan by building schools and training teachers in rural communities.",
        location: "Bamyan, Afghanistan",
        goal: 50000,
        charity: Charity.find_by(name: "Save the Children"),
        photos: [
          Rails.root.join("db/seed-images/save-the-children/education-afghanistan.avif")
        ]
      }, {
        name: "Emergency Aid in Syria",
        description: "Save the Children is providing emergency aid in Syria by delivering food, water, and medical supplies to families affected by the conflict.",
        location: "Aleppo, Syria",
        goal: 50000,
        charity: Charity.find_by(name: "Save the Children"),
        photos: [
          Rails.root.join("db/seed-images/save-the-children/syria.avif")
        ]
      }, {
        name: "Fighting Malnutrition in South Sudan",
        description: "Save the Children is fighting malnutrition in South Sudan by providing food, water, and medical care to children suffering from hunger.",
        location: "Juba, South Sudan",
        goal: 50000,
        charity: Charity.find_by(name: "Save the Children"),
        photos: [
          Rails.root.join("db/seed-images/save-the-children/sudan.avif")
        ]
      }
    ]

    charity_projects_wwf = [{
        name: "World Wildlife Fund (WWF)",  # Replace with the actual title of the new project
        description: "This project directly funds WWF, helping to support its mission of conserving nature and reducing the most pressing threats to the environment.",
        location: "Gland, Switzerland",  # Specify the location
        goal: 85000,  # Set a funding goal
        charity: Charity.find_by(name: "World Wildlife Fund (WWF)"),  # Link to the charity
        photos: [
          Rails.root.join("db/seed-images/wwf/wwf.png")  # Path to an image related to the new project
        ]
      }, {
        name: "Protecting Endangered Species",
        description: "WWF is dedicated to protecting endangered species across the globe through conservation efforts and habitat protection.",
        location: "Maasai Mara, Kenya",
        goal: 80000,
        charity: Charity.find_by(name: "World Wildlife Fund (WWF)"),
        photos: [
          Rails.root.join("db/seed-images/wwf/endangered.avif")
        ]
      }, {
        name: "Forest Conservation in the Amazon",
        description: "WWF is working to conserve the Amazon rainforest by promoting sustainable land practices and protecting native species.",
        location: "Manaus, Brazil",
        goal: 100000,
        charity: Charity.find_by(name: "World Wildlife Fund (WWF)"),
        photos: [
          Rails.root.join("db/seed-images/wwf/amazon.avif")
        ]
      }, {
        name: "Marine Ecosystem Restoration",
        description: "WWF is focused on restoring marine ecosystems to protect ocean biodiversity and sustain coastal communities.",
        location: "Great Barrier Reef, Australia",
        goal: 90000,
        charity: Charity.find_by(name: "World Wildlife Fund (WWF)"),
        photos: [
          Rails.root.join("db/seed-images/wwf/marine-eco.avif")
        ]
      }
    ]

    charity_projects_sierra_club = [{
        name: "The Sierra Club Foundation",  # Replace with the actual title of the new project
        description: "This project directly funds The Sierra Club Foundation, helping to support its mission of promoting climate solutions and protecting natural ecosystems.",
        location: "Oakland, CA, USA",  # Specify the location
        goal: 80000,  # Set a funding goal
        charity: Charity.find_by(name: "The Sierra Club Foundation"),  # Link to the charity
        photos: [
          Rails.root.join("db/seed-images/sierra-club/sierra-club.jpg")  # Path to an image related to the new project
        ]
      }, {
        name: "Preserving National Parks",
        description: "The Sierra Club Foundation is dedicated to preserving America's national parks, ensuring these natural treasures are protected for future generations.",
        location: "Yosemite National Park, USA",
        goal: 85000,
        charity: Charity.find_by(name: "The Sierra Club Foundation"),
        photos: [
          Rails.root.join("db/seed-images/sierra-club/national-parks.avif")
        ]
      }, {
        name: "Clean Energy Transition",
        description: "The Sierra Club Foundation supports the transition to clean, renewable energy sources to combat climate change and reduce pollution.",
        location: "Austin, USA",
        goal: 95000,
        charity: Charity.find_by(name: "The Sierra Club Foundation"),
        photos: [
          Rails.root.join("db/seed-images/sierra-club/clean-energy.avif")
        ]
      }, {
        name: "Protecting Wildlife Habitats",
        description: "The Sierra Club Foundation works to protect wildlife habitats by advocating for sustainable land use and conservation policies.",
        location: "Yellowstone National Park, USA",
        goal: 70000,
        charity: Charity.find_by(name: "The Sierra Club Foundation"),
        photos: [
          Rails.root.join("db/seed-images/sierra-club/habitats.avif")
        ]
      }
    ]

    charity_projects_friends_of_the_earth = [{
      name: "Friends of the Earth",  # Replace with the actual title of the new project
      description: "This project directly funds Friends of the Earth, helping to support its mission of promoting environmental justice and sustainability worldwide.",
      location: "Amsterdam, Netherlands",  # Specify the location
      goal: 70000,  # Set a funding goal
      charity: Charity.find_by(name: "Friends of the Earth"),  # Link to the charity
      photos: [
        Rails.root.join("db/seed-images/friends-of-earth/banner.png")  # Path to an image related to the new project
      ]
    }, {
      name: "Campaign for Clean Air",
      description: "Friends of the Earth is leading a campaign to improve air quality in urban areas by reducing pollution and promoting green energy solutions.",
      location: "London, UK",
      goal: 60000,
      charity: Charity.find_by(name: "Friends of the Earth"),
      photos: [
        Rails.root.join("db/seed-images/friends-of-earth/dust-delhi-01-10-24-E-hero.jpg")
      ]
    }, {
      name: "Protecting Pollinators",
      description: "Friends of the Earth is working to protect pollinators like bees by advocating against harmful pesticides and supporting organic farming.",
      location: "California, USA",
      goal: 75000,
      charity: Charity.find_by(name: "Friends of the Earth"),
      photos: [
        Rails.root.join("db/seed-images/friends-of-earth/Protecting-Pollinators-Safeguarding-Natures-Essential-Insect-Workforce.jpg")
      ]
    }, {
      name: "Fighting Plastic Pollution",
      description: "Friends of the Earth is fighting plastic pollution by promoting sustainable alternatives and reducing single-use plastics.",
      location: "Sydney, Australia",
      goal: 65000,
      charity: Charity.find_by(name: "Friends of the Earth"),
      photos: [
        Rails.root.join("db/seed-images/friends-of-earth/istockphoto-1442904386-612x612-2.jpg")
      ]
    }
  ]

    charity_projects_rainforest_alliance = [{
        name: "Rainforest Alliance",  # Replace with the actual title of the new project
        description: "This project directly funds the Rainforest Alliance, helping to support its mission of conserving biodiversity and ensuring sustainable livelihoods.",
        location: "New York City, United States",  # Specify the location
        goal: 75000,  # Set a funding goal
        charity: Charity.find_by(name: "Rainforest Alliance"),  # Link to the charity
        photos: [
          Rails.root.join("db/seed-images/rainforest-alliance/rainforest-alliance.avif")  # Path to an image related to the new project
        ]
      }, {
        name: "Sustainable Farming in the Amazon",
        description: "The Rainforest Alliance promotes sustainable farming practices in the Amazon to protect biodiversity and support local communities.",
        location: "Acre, Brazil",
        goal: 90000,
        charity: Charity.find_by(name: "Rainforest Alliance"),
        photos: [
          Rails.root.join("db/seed-images/rainforest-alliance/farming-amazon.jpg")
        ]
      }, {
        name: "Forest Conservation in Central America",
        description: "The Rainforest Alliance works to conserve forests in Central America by advocating for sustainable land use and protecting wildlife.",
        location: "Petén, Guatemala",
        goal: 80000,
        charity: Charity.find_by(name: "Rainforest Alliance"),
        photos: [
          Rails.root.join("db/seed-images/rainforest-alliance/central-forest.avif")
        ]
      }, {
        name: "Protecting Indigenous Land Rights",
        description: "The Rainforest Alliance supports indigenous communities in protecting their land rights to preserve forests and traditional ways of life.",
        location: "Madre de Dios, Peru",
        goal: 85000,
        charity: Charity.find_by(name: "Rainforest Alliance"),
        photos: [
          Rails.root.join("db/seed-images/rainforest-alliance/indigenous.avif")
        ]
      }
    ]

    charity_projects_climateworks = [{
        name: "ClimateWorks Foundation",  # Replace with the actual title of the new project
        description: "This project directly funds ClimateWorks, helping to support its mission of driving global climate solutions and reducing greenhouse gas emissions.",
        location: "San Francisco, USA",  # Specify the location
        goal: 110000,  # Set a funding goal
        charity: Charity.find_by(name: "ClimateWorks Foundation"),  # Link to the charity
        photos: [
          Rails.root.join("db/seed-images/climateworks/climate-works.avif")  # Path to an image related to the new project
        ]
      }, {
        name: "Accelerating Clean Energy Solutions",
        description: "ClimateWorks Foundation is driving the transition to clean energy solutions worldwide to reduce carbon emissions and combat climate change.",
        location: "San Francisco, USA",
        goal: 100000,
        charity: Charity.find_by(name: "ClimateWorks Foundation"),
        photos: [
          Rails.root.join("db/seed-images/climateworks/clean-ener-solutions.avif")
        ]
      }, {
        name: "Supporting Sustainable Urban Development",
        description: "ClimateWorks Foundation supports sustainable urban development initiatives to promote low-carbon, resilient cities.",
        location: "Copenhagen, Denmark",
        goal: 120000,
        charity: Charity.find_by(name: "ClimateWorks Foundation"),
        photos: [
          Rails.root.join("db/seed-images/climateworks/urban-dev.avif")
        ]
      }, {
        name: "Reducing Deforestation in Southeast Asia",
        description: "ClimateWorks Foundation is working to reduce deforestation in Southeast Asia by supporting sustainable land management practices.",
        location: "Borneo, Indonesia",
        goal: 95000,
        charity: Charity.find_by(name: "ClimateWorks Foundation"),
        photos: [
          Rails.root.join("db/seed-images/climateworks/deforest.webp")
        ]
      }
    ]

    charity_projects_doctors_without_borders = [
      {
        name: "Doctors Without Borders",
        description: "This project directly funds Doctors Without Borders, supporting its mission to provide medical care to those in crisis around the world, regardless of race, religion, or political affiliation.",
        location: "Geneva, Switzerland",
        goal: 60000,
        charity: Charity.find_by(name: "Doctors Without Borders"),
        photos: [
          Rails.root.join("db/seed-images/doctors-without-borders/doctors-without-borders.jpg")
        ]
      },
      {
        name: "Emergency Medical Aid in Yemen",
        description: "Doctors Without Borders is providing urgent medical assistance to the conflict-affected population in Yemen, focusing on trauma care, surgery, and nutritional support for children.",
        location: "Sana'a, Yemen",
        goal: 70000,
        charity: Charity.find_by(name: "Doctors Without Borders"),
        photos: [
          Rails.root.join("db/seed-images/doctors-without-borders/medical-yemen.jpg")
        ]
      },
      {
        name: "Ebola Treatment Centers in West Africa",
        description: "Doctors Without Borders is leading efforts to combat the Ebola outbreak in West Africa, providing treatment, care, and education to stop the spread of the virus.",
        location: "Conakry, Guinea",
        goal: 80000,
        charity: Charity.find_by(name: "Doctors Without Borders"),
        photos: [
          Rails.root.join("db/seed-images/doctors-without-borders/ebola-west.png")
        ]
      },
      {
        name: "Healthcare for Refugees in Greece",
        description: "Doctors Without Borders is delivering essential healthcare to refugees and migrants stranded in Greece, including treatment for trauma, infectious diseases, and mental health support.",
        location: "Lesbos, Greece",
        goal: 75000,
        charity: Charity.find_by(name: "Doctors Without Borders"),
        photos: [
          Rails.root.join("db/seed-images/doctors-without-borders/greece-refugees.webp")
        ]
      }
    ]

    charity_projects_unicef = [
      {
        name: "UNICEF",
        description: "This project directly funds UNICEF, helping to provide lifesaving support to children in need worldwide, including education, nutrition, health care, and emergency assistance.",
        location: "New York, USA",
        goal: 80000,
        charity: Charity.find_by(name: "UNICEF"),
        photos: [
          Rails.root.join("db/seed-images/unicef/unicef.jpeg")
        ]
      },
      {
        name: "Vaccinating Children in Somalia",
        description: "UNICEF is working to vaccinate children in Somalia against preventable diseases, including measles and polio, to protect their health and prevent outbreaks.",
        location: "Mogadishu, Somalia",
        goal: 70000,
        charity: Charity.find_by(name: "UNICEF"),
        photos: [
          Rails.root.join("db/seed-images/unicef/vacc-somalia.jpg")
        ]
      },
      {
        name: "Education for Refugee Children in Lebanon",
        description: "UNICEF is providing education to refugee children in Lebanon, ensuring they have access to schooling and learning resources despite the ongoing refugee crisis.",
        location: "Beirut, Lebanon",
        goal: 85000,
        charity: Charity.find_by(name: "UNICEF"),
        photos: [
          Rails.root.join("db/seed-images/unicef/children-lebanon.jpeg")
        ]
      },
      {
        name: "Nutrition Support for Children in South Sudan",
        description: "UNICEF is addressing child malnutrition in South Sudan by providing life-saving nutritional support to children suffering from hunger and malnutrition.",
        location: "Juba, South Sudan",
        goal: 95000,
        charity: Charity.find_by(name: "UNICEF"),
        photos: [
          Rails.root.join("db/seed-images/unicef/nutrition-sudan.jpg")
        ]
      }
    ]

    charity_projects_red_cross = [
      {
        name: "Red Cross",
        description: "This project directly funds the Red Cross, supporting its mission to provide emergency relief and disaster response, and to help vulnerable communities globally in times of crisis.",
        location: "Geneva, Switzerland",
        goal: 90000,
        charity: Charity.find_by(name: "Red Cross"),
        photos: [
          Rails.root.join("db/seed-images/red-cross/red-cross.webp")
        ]
      },
      {
        name: "Disaster Relief in the Philippines",
        description: "The Red Cross is delivering urgent disaster relief in the Philippines following typhoons, providing food, water, shelter, and medical support to affected communities.",
        location: "Manila, Philippines",
        goal: 85000,
        charity: Charity.find_by(name: "Red Cross"),
        photos: [
          Rails.root.join("db/seed-images/red-cross/disaster-philippines.jpg")
        ]
      },
      {
        name: "Aid for Syrian Refugees",
        description: "The Red Cross is providing essential aid to Syrian refugees, including shelter, healthcare, and psychosocial support for families displaced by the conflict.",
        location: "Amman, Jordan",
        goal: 100000,
        charity: Charity.find_by(name: "Red Cross"),
        photos: [
          Rails.root.join("db/seed-images/red-cross/aid-syrian.jpg")
        ]
      },
      {
        name: "Supporting Healthcare in Yemen",
        description: "The Red Cross is supporting healthcare systems in Yemen, providing emergency medical care and helping to rebuild hospitals in conflict zones to treat the wounded.",
        location: "Sana'a, Yemen",
        goal: 95000,
        charity: Charity.find_by(name: "Red Cross"),
        photos: [
          Rails.root.join("db/seed-images/red-cross/healthcare-yemen.webp")
        ]
      }
    ]

    charity_projects_all = charity_projects_oxfam + charity_projects_greenpeace + charity_projects_save_the_children + charity_projects_wwf + charity_projects_sierra_club + charity_projects_friends_of_the_earth + charity_projects_rainforest_alliance + charity_projects_climateworks + charity_projects_doctors_without_borders + charity_projects_unicef + charity_projects_red_cross

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
  end

  create_charity_projects

# Create donations
  def create_donations
    puts "Creating donations..."

    40.times do
      Donation.create!(
        recurrent: [true, false].sample,
        amount: rand(5..10000),
        user: User.first(3).sample,
        state: "paid",
        charity_project: CharityProject.all.sample)
    end

    puts "#{Donation.count} donations created."
  end

  create_donations

# Create reports

  puts "Creating reports..."

  # Scraper for Article Reports

  def report_scraper
    scraped_reports = []
    # Def base url with charity projects to be scraped
    base_url = "https://www.globalgiving.org/"
    # Def url for reports of the charity project

    category_urls = {
      climate_change: "https://www.globalgiving.org/search/?size=25&nextPage=1&sortField=sortorder&selectedThemes=climate&loadAllResults=true",
      basic_needs: "https://www.globalgiving.org/search/?size=25&nextPage=1&sortField=sortorder&selectedThemes=ecdev&selectedThemes=endabuse&selectedThemes=housing&selectedThemes=water&loadAllResults=true",
      education: "https://www.globalgiving.org/search/?size=25&nextPage=1&selectedThemes=edu&loadAllResults=true", health: "https://www.globalgiving.org/search/?size=25&nextPage=1&sortField=sortorder&selectedThemes=health&selectedThemes=mentalhealth&selectedThemes=reproductive&loadAllResults=true",
      natural_disasters: "https://www.globalgiving.org/search/?size=25&nextPage=1&sortField=sortorder&selectedThemes=disaster&loadAllResults=true",
      famine: "https://www.globalgiving.org/search/?size=25&nextPage=1&sortField=sortorder&selectedThemes=hunger&loadAllResults=true"}

    # Test Scraping of the page
    category_urls.first(2).each do |category_name, category_url|
      projects_page = URI.open(category_url).read
      projects_doc = Nokogiri::HTML(projects_page).search(".js-projTitle")
      projects_doc.each_with_index do |element, index|
        project_page = URI.open("#{base_url + element.attribute("href").value}/reports/").read
        project_reports = Nokogiri::HTML(project_page).search(".projectReport")
        project_title = Nokogiri::HTML(project_page).search(".cuke-project div h1").text
        project_category = Category.find_by(name: category_name.to_s.titleize)

        puts project_category.name

        puts "creating Reports for Project #{index + 1} / #{projects_doc.count}: #{project_title}"
        project_reports.each_with_index do |scraped_report, ind|
          puts "creating Report #{ind} / #{project_reports.count}: #{scraped_report.search("h3 > span").text}"
          content = ""
          scraped_report.search("div > p").each do |p|
            content += p.text
          end
          teaser_content = ""
          content.split(".").each do |sentence|
            teaser_content += sentence unless ( teaser_content.length + sentence.length ) > 300
          end
          if teaser_content == ""
            teaser_content = "Read the full Article to learn more."
          end
          # Safe inside project_math a random project that belongs to a chraity organisation that belongs to my_category
          project_match = CharityProject.joins(charity: :category).where(charity: { category: project_category}).sample.name
          report = {
            report_type: "article",
            user: User.where(role: 2).sample.email,
            title: scraped_report.search("h3 > span").text,
            body: content,
            # cut the content after a fullstop with a max of 300 characters
            teaser: teaser_content,
            charity_project: project_match
          }
          scraped_reports << report
        end
      end
    end
    File.open("db/reports.json", "wb") do |file|
      file.write(JSON.generate(scraped_reports))
    end
  end


  # Save Article Reports in DB

  reports_file = File.read("db/reports.json")
  if reports_file.empty?
    report_scraper
    reports_file = File.read("db/reports.json")

  end
  article_reports  = JSON.parse(reports_file)

  article_reports.each_with_index do |report, index|
    a_report = Report.new(title: report["title"], body: report["body"], teaser: report["teaser"], report_type: report["report_type"].capitalize)
    a_report.user = User.find_by(email: report["user"])
    a_report.charity_project = CharityProject.find_by(name: report["charity_project"])
    a_report.save!
    puts "Article Report #{index + 1} / #{article_reports.count}: #{a_report.title} created."
  end

  # Create Evaluation Reports
  evaluation_reports = []

  CharityProject.all.each do |project|
    i = 1
    3.times do
      evaluation_report = {
        report_type: "Evaluation",
        user: User.where(role: 3).sample,
        score: rand(75..100),
        score_impact: rand(75..100),
        score_communication: rand(75..100),
        score_efficiency: rand(75..100),
        score_adaptability: rand(75..100),
        title: "Report Q#{i} 2024",
        body: "This evaluation report provides an overview of the impact and outcomes of the project, including key achievements, challenges, and recommendations for future initiatives.<h1>Impact</h1>
        <p>The project has demonstrated a significant impact on the target community, with measurable improvements in key areas such as access to education, healthcare, and economic opportunities. The implementation of sustainable solutions has led to positive outcomes for local residents, contributing to long-term development and well-being.</p>
        <h1>Communication</h1>
        <p>The project team has effectively communicated with stakeholders, partners, and beneficiaries throughout the project lifecycle, ensuring transparency, accountability, and engagement. Regular updates, reports, and feedback mechanisms have facilitated meaningful dialogue and collaboration, enhancing the overall success of the initiative.</p>
        <h1>Efficiency</h1>
        <p>The project has demonstrated high levels of efficiency in resource management, budget allocation, and timeline adherence. The team's strategic planning, monitoring, and evaluation processes have optimized project delivery, resulting in cost-effective solutions and timely outcomes.</p>
        <h1>Adaptability</h1>
        <p>The project team has shown flexibility and adaptability in responding to changing circumstances, unforeseen challenges, and evolving needs. By adjusting strategies, activities, and approaches as required, the project has maintained relevance, effectiveness, and sustainability over time.</p>",
        teaser: "Read the evaluation report to learn more about the impact of this project.",
        charity_project: project
      }
      Report.create!(evaluation_report)
      i += 1
    end
    puts "#{i - 1} Evaluation reports created for #{project.name}."
  end




  charity_projects_oxfam = [{
    name: "Oxfam",  # This is now the first project
    description: "This project directly funds Oxfam, helping to support its core mission of fighting poverty and inequality around the world.",
    location: "Nairobi, Kenya",
    goal: 50000,
    charity: Charity.find_by(name: "Oxfam"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/GP0STPOUA_8.webp")
    ]
  }, {
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
    description: "Oxfam is promoting sustainable development in India by supporting small-scale farmers.",
    # A village in India named Khandwa
    location: "Khandwa, India",
    goal: 50000,
    charity: Charity.find_by(name: "Oxfam"),
    photos: [
      Rails.root.join("db/seed-images/greenpeace/DSC_9026-1.jpg")
    ]
  }
]

# Create discussions for specific charity projects
  puts "Creating discussions and comments for selected charity projects..."

  # Find the charity projects to add discussions to
  charity_project_clean_air = CharityProject.find_by(name: "Campaign for Clean Air")
  charity_project_decarbonization = CharityProject.find_by(name: "Campaigning for Decarbonization in Brussels")

  # Define sample discussions and comments
  discussion_titles = ["Future of Air Quality", "Renewable Energy Solutions", "Community Initiatives for Clean Air"]
  discussion_descriptions = [
    "Let's discuss the various factors impacting air quality and how we can make a difference.",
    "How renewable energy sources can help reduce pollution and improve air quality.",
    "Exploring community-driven efforts to improve air quality and reduce pollution."
  ]
  comment_contents = [
    "Great point! I think awareness is key.",
    "This initiative will have a significant impact on future generations.",
    "We need more government support for these projects.",
    "Public engagement is crucial for success.",
    "Looking forward to seeing positive changes!"
  ]

  # Function to create discussions and comments for a charity project
  def create_discussions_with_comments(charity_project, discussion_titles, discussion_descriptions, comment_contents, users)
    discussion_titles.each_with_index do |title, index|
      discussion = charity_project.discussions.create!(
        title: title,
        description: discussion_descriptions[index],
        user: users.sample # Assign a random user as the author
      )
      puts "Discussion '#{discussion.title}' created for #{charity_project.name}"

      # Create comments for each discussion
      5.times do
        discussion.comments.create!(
          content: comment_contents.sample,
          user: users.sample # Assign a random user as the author
        )
      end
      puts "5 comments created for discussion '#{discussion.title}'"
    end
  end

  # Get all users to assign authorship randomly
  users = User.all

  # Create discussions and comments for each specified charity project
  create_discussions_with_comments(charity_project_clean_air, discussion_titles, discussion_descriptions, comment_contents, users) if charity_project_clean_air
  create_discussions_with_comments(charity_project_decarbonization, discussion_titles, discussion_descriptions, comment_contents, users) if charity_project_decarbonization

  puts "Discussions and comments seeded successfully!"


puts "Seeding complete!"
