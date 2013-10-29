module ApplicationHelper

  def session_links
    if current_user
       link_to 'Sign out', signout_path, method: :delete
    else
      link_to 'Sign in with Github', '/auth/github/'
    end
  end

  def button_classes active
    active ? ['active', 'inactive'] : ['inactive', 'active']
  end

end
