module ApplicationHelper

  def link_to_sign_in
    if current_user
        sign_in_container { link_to 'Sign out', signout_path }
    else
      sign_in_container { link_to 'Sign in with Github', '/auth/github/' }
    end
  end

  def link_to_dashboard
    link_to 'dashboard', dashboard_user_path(current_user.nickname) if current_user
  end

  private

  def sign_in_container
    content_tag :div, class: 'btn btn-success pull-right' do
      yield
    end
  end

end
