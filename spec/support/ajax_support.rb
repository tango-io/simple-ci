module AjaxSupport

  def wait_for_ajax
    Timeout.timeout(Capybara.default_wait_time) do
      loop do
        active = page.driver.evaluate_script('jQuery.active')
        break if active == 0
      end
    end
  end

end
