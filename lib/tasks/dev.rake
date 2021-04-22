task sample_data: :environment do
  p "Creating sample data"

  if Rails.env.development? 
    Comment.destroy_all
    Like.destroy_all
    Photo.destroy_all
    FollowRequest.destroy_all
    User.destroy_all
  end


  usernames = Array.new {Fake::Name.first_name}

  usernames << "alice"
  usernames << "bob"


  usernames.each do |username|
    u = User.create(
      email: "#{username}@example.com",
      username: username.downcase,
      password: "password",
      private: [true,false].sample 
    ) 
  end
  p "#{User.count} users have been created"


  users = User.all

  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample
        )
      end 


      if rand < 0.75
        second_user.sent_follow_requests.create(
          recipient: first_user,
          status: FollowRequest.statuses.keys.sample
        )
      end 


    end 
  end 

  p "#{FollowRequest.count} follow requests habe been created."


  users.each do |user|
    10.times do 
      photo = user.own_photos.create(
        caption: Faker::Quote.jack_handey,
        image: "https://robohash.org/#{rand(1000000)}"
      )

      user.followers.each do |follower|
        if rand < 0.25 
          photo.fans << follower
        end 

        if rand < 0.1
          photo.comments.create(
            body: Faker::Quote.jack_handey, 
            author: follower
          )
        end 
      end 
    end 
  end

  p "There are now #{Photo.count}  photos."
  p "There are now #{Like.count}  likes."
  p "There are now #{Comment.count}  comments."

end