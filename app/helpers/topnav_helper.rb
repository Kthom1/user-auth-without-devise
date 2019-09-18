module TopnavHelper
  def correct_nav_links_path
    if current_user 
      'layouts/signed_in'
    else
      'layouts/not_signed_in'
    end
  end
end