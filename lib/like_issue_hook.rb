class Hooks < Redmine::Hook::ViewListener
  render_on :view_issues_show_action_menu, :partial => 'issues/like'
end
