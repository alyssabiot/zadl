module ApplicationHelper
  def avatar(user)
   if user.photo.present?
     cl_image_tag(user.photo, height: 38, width: 38, crop: :fill, gravity: :face, class: "avatar")
   elsif user.facebook_picture_url.present?
     image_tag user.facebook_picture_url, height: 38, width: 38, crop: :fill, gravity: :face, class: "avatar"
   else
     image_tag "default-profile.png", height: 38, width: 38, class: "avatar"
   end
  end

  def avatar_large(user)
   if user.photo.present?
     cl_image_tag(user.photo, height: 100, width: 100, crop: :fill, gravity: :face, class: "avatar-large")
   elsif user.facebook_picture_url.present?
     image_tag user.facebook_picture_url, height: 100, width: 100, crop: :fill, gravity: :face, class: "avatar-large"
   else
     image_tag "default-profile.png", height: 100, width: 100, class: "avatar-large"
   end
  end

  def avatar_medium(user)
    if user.nil?
      image_tag "rest.jpg", height: 60, width: 60, class: "avatar-medium"
    elsif user.photo.present?
      cl_image_tag(user.photo, height: 60, width: 60, crop: :fill, gravity: :face, class: "avatar-medium")
    elsif user.facebook_picture_url.present?
      image_tag user.facebook_picture_url, height: 60, width: 60, crop: :fill, gravity: :face, class: "avatar-medium"
    else
      image_tag "default-profile.png", height: 60, width: 60, class: "avatar-medium"
   end
  end

  def avatar_dropdown(user)
   if user.photo.present?
     cl_image_tag(user.photo, height: 38, width: 38, crop: :fill, gravity: :face, class: "avatar dropdown-toggle", id: "navbar-wagon-menu", "data-toggle" => "dropdown")
   elsif user.facebook_picture_url.present?
     image_tag user.facebook_picture_url, height: 38, width: 38, crop: :fill, gravity: :face, class: "avatar dropdown-toggle", id: "navbar-wagon-menu", "data-toggle" => "dropdown"
   else
     image_tag "default-profile.png", height: 38, width: 38, class: "avatar dropdown-toggle", id: "navbar-wagon-menu", "data-toggle" => "dropdown"
   end
  end

  def url_photo(event)
    if event.photo.present?
      cl_image_path event.photo, crop: :fill, gravity: :south
    else
      image_path "default-event.png"
    end
  end

  def has_a_booking_not_cancelled?(user, event)
    result = false
    user.bookings.each do |booking|
      if booking.event == event && booking.cancelled == false
        result = true
      end
    end
    return result
  end

  def has_a_booking_cancelled?(user, event)
    result = false
    user.bookings.each do |booking|
      if booking.event == event && booking.cancelled == true
        result = true
      end
    end
    return result
  end

  def booking_find_by_user_and_event(user,event)
    result = "No booking"
    user.bookings.each do |booking|
      if (booking.event == event && booking.state == 'paid') || (booking.event == event && booking.on_waiting_list == true)
        result = booking
      end
    end
    return result
  end
end
