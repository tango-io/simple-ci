module ApplicationHelper

  def session_links
    if current_user
       link_to 'Sign out', signout_path
    else
      link_to 'Sign in with Github', '/auth/github/'
    end
  end

  def link_to_dashboard
    link_to 'dashboard', dashboard_user_path(current_user) if current_user
  end

end
