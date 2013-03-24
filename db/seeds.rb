# coding: utf-8

def category_create(category_name, section)
  category =
    Category.create!(
      :name => category_name,
      :section => section
    )

  puts "Created category [#{category.id}] - #{category.name}"
end

def item_create
  item =
    Item.create!(
      :title => Faker::Lorem.sentence,
      :text => Faker::Lorem.paragraphs.join("\n")
    )

  [*1..3].sample.times do
    item.pics.create!(
      :attach => File.open("#{Rails.root}/test/fixtures/pic.jpg")
    )
  end

  [*1..3].sample.times do
    category = Category.all.sample
    item.categories << category if !item.categories.include?(category)
  end

  puts "Created item [#{item.id}] – #{item.title}"
end

def admin_create
  email = "admin@email.com"
  password = "pass"
  admin_user =
    AdminUser.create!(
      :name => "Super Admin",
      :email => email,
      :password => password,
      :password_confirmation => password
    )

  puts "AdminUser created #{email}/#{password}"
end

ActiveRecord::Base.transaction do
  [
    "book cover",
    "editorial",
    "essay photo",
    "new",
    "identity",
    "web",
    "miscelanea"
  ].each do |category_name|
    category_create(category_name, Category::SECTIONS[:work])
  end

  [
    "escritoalapiz",
    "deslab",
    "laosamoña"
  ].each do |category_name|
    category_create(category_name, Category::SECTIONS[:projects])
  end

  [
    "profile",
    "contact"
  ].each do |category_name|
    category_create(category_name, Category::SECTIONS[:about])
  end

  10.times { item_create }

  admin_create
end