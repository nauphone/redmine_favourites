class FavouritesController < ApplicationController
  unloadable

  def like
    if User.current.pref[:others][:issue_like].nil?
      User.current.pref[:others][:issue_like] = Array.new
      User.current.pref.save
    end
    unless User.current.pref[:others][:issue_like].include?(params[:id].to_i)
      User.current.pref[:others][:issue_like] += [ params[:id].to_i ]
      User.current.pref.save
    end
    redirect_to :back
  end

  def unlike
    if User.current.pref[:others][:issue_like].nil?
      User.current.pref[:others][:issue_like] = Array.new
      User.current.pref.save
    end
    User.current.pref[:others][:issue_like] -= [ params[:id].to_i ]
    User.current.pref.save
    redirect_to :back
  end

end
