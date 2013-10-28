module ApplicationHelper

  def session_links
    if current_user
       link_to 'Sign out', signout_path, method: :delete
    else
      link_to 'Sign in with Github', '/auth/github/'
    end
  end

  def repo_active?(url)
    current_user.has_repo?(url)
  end

end
