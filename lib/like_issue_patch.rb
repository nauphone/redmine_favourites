module LikeIssuePatch
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods

    def like?
      if User.current.pref[:others][:issue_like].nil?
        User.current.pref[:others][:issue_like] = Array.new
        User.current.pref.save
      end
      User.current.pref[:others][:issue_like].include?(self.id)
    end

  end
end

Issue.send(:include, LikeIssuePatch)