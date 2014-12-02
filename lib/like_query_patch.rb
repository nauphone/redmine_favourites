module LikeQueryPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      alias_method_chain :available_filters, :redmine_like
      alias_method_chain :sql_for_field, :redmine_like
    end
  end

  module InstanceMethods
    def available_filters_with_redmine_like
      @available_filters = available_filters_without_redmine_like
      like_filter = {
          "like" => {
            :type => :list,
            :name => l(:field_like_state),
            :values => [['yes', '1'], ['no', '0']]
          }
        }
      @available_filters.merge(like_filter)
    end
    def sql_for_field_with_redmine_like(field, operator, v, db_table, db_field, is_custom_filter=false)
      if field == "like"
        if User.current.pref[:others][:issue_like].nil?
          User.current.pref[:others][:issue_like] = Array.new
          User.current.pref.save
        end
        like_issues = User.current.pref[:others][:issue_like]
        if like_issues.empty?
          return sql = "1=1"
        end
        case operator
          when "=" #is
            if v[0].to_i == 1
              #yes
              sql = "(#{Issue.table_name}.id in (#{like_issues.join(',')}))"
            else
              #no
              sql = "(#{Issue.table_name}.id not in (#{like_issues.join(',')}))"
            end
          when "!" #is not
            if v[0].to_i == 1
              #yes
              sql = "(#{Issue.table_name}.id not in (#{like_issues.join(',')}))"
            else
              #no
              sql = "(#{Issue.table_name}.id in (#{like_issues.join(',')}))"
            end
        end
      else
        return sql_for_field_without_redmine_like(field, operator, v, db_table, db_field, is_custom_filter)
      end
    end
  end
end
IssueQuery.send(:include, LikeQueryPatch)