module ApplicationHelper
  def avatar(user, options = { height: 1000, width: 1000, crop: :fill, gravity: :face })
    options_min = options.except!(:crop, :gravity)
    if user.nil?
      image_tag "rest.jpg", options_min
    elsif user.photo.present?
      cl_image_tag(user.photo, options)
    elsif user.facebook_picture_url.present?
      image_tag user.facebook_picture_url, options_min
    else
      image_tag "default-profile.png", options_min
    end
  end

  def url_photo(event)
    if event.photo.present?
      cl_image_path event.photo
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
      if booking.event == event
        result = booking
      end
    end
    return result
  end
end
