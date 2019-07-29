module UsersHelper
  def gravatar_for user, options = {size: Settings.user.gravatar_size}
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.username,
    class: "gravatar rounded-circle img-fluid"
  end
end