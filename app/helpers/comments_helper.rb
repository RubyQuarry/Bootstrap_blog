module CommentsHelper
  def gravatar_for(user = 'ajn123@vt.edu', options = { size: 40 })
    user = user.email || 'ajn123@vt.edu'
    gravatar_id = Digest::MD5::hexdigest(user.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user, id: "profile_image")
  end
end
