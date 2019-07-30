10.times do
  City.create(
    name: Faker::Address.city
    )
end

TypeTravelPlace.create(
  name: "Hotels"
)
TypeTravelPlace.create(
  name: "Travel"
)
TypeTravelPlace.create(
  name: "Foods"
)

cities = City.order(:created_at).take(Faker::Number.within(1..3))
type_travel_places = TypeTravelPlace.order(:created_at)
cities.each do |city|
  type_travel_places.each do |type_travel_place|
    10.times do
      TravelPlace.create! name: Faker::Restaurant.name,
        content: Faker::Restaurant.description,
        address: Faker::Address.street_address,
        rate: Faker::Number.between(1,5),
        city_id: city.id,
        type_travel_place_id: type_travel_place.id
    end
  end
end

travel_places = TravelPlace.order(:created_at)
travel_places.each do |travel_place|
  case travel_place.type_travel_place_id
    when 1
      3.times do |i|
        TravelPlaceImage.create! link: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/hotels/#{i+1}.jpg",
                       travel_place_id: travel_place.id
      end
    when 2
       4.times do |i|
        TravelPlaceImage.create! link: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/play_places/#{i+1}.jpg",
                       travel_place_id: travel_place.id
      end
    when 3
       5.times do |i|
        TravelPlaceImage.create! link: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/food/#{i+1}.jpg",
                       travel_place_id: travel_place.id
    end
  end
end

User.create! username:  "admin",
  email: "admin@gmail.com",
  gender: "male",
  date_of_birth: "1/1/2018",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true,
  activated: true,
  activated_at: Time.zone.now

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! username:  name,
    email: email,
    gender: Faker::Gender.binary_type,
    date_of_birth: Faker::Date.between(50.years.ago, 10.years.ago),
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
end

users = User.order(:id).take(5)
users.each do |user|
    16.times do
      Post.create! title: Faker::Lorem.sentence(3, true, 4),
                   content: Faker::Lorem.paragraph(2, false, 4),
                   vote_point: Faker::Number.between(1,5),
                   view: Faker::Number.number(3),
                   user_id: user.id,
                   travel_place_id: Faker::Number.between(1,50)
    end
end

posts = Post.order(:created_at)
posts.each do |post|
   case post.travel_place.type_travel_place_id
    when 1
      3.times do |i|
        PostImage.create! link: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/hotels/#{i+1}.jpg",
                       post_id: post.id
      end
    when 2
       4.times do |i|
        PostImage.create! link: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/play_places/#{i+1}.jpg",
                       post_id: post.id
      end
    when 3
       5.times do |i|
        PostImage.create! link: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/food/#{i+1}.jpg",
                       post_id: post.id
      end
    end
end

users = User.order(:created_at).take(24)
posts = Post.order(:created_at).take(32)
posts.each do |post|
  users.each do |user|
    Comment.create! content: Faker::Lorem.sentence,
      user_id: user.id,
      post_id: post.id
  end
end

ReactionType.create(
  description: "like"
)

reaction_type_id = ReactionType.first.id
users = User.order(:created_at).take(32)
posts = Post.order(:created_at).take(26)
posts.each do |post|
  users.each do |user|
    Reaction.create! reaction_type_id: reaction_type_id,
      user_id: user.id,
      post_id: post.id
  end

end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
