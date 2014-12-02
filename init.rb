require 'redmine'
require 'like_query_patch'
require 'like_issue_patch'
require 'like_issue_hook'

Redmine::Plugin.register :redmine_favourites do
  name 'Favourites_issue_hook plugin'
  author 'Milan Stastny of ALVILA SYSTEMS. Naumen'
  description 'Bookmarking favourite tasks by Like button with Query inclusion'
  version '0.0.2'
  author_url 'http://www.alvila.com http://naumen.ru'
end

class RedmineFavoritesHookListener < Redmine::Hook::ViewListener
   def view_layouts_base_html_head(context)
     stylesheet_link_tag('redmine_like.css', :plugin => :redmine_favourites)
  end
end

