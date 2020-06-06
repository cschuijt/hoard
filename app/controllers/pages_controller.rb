class PagesController < ApplicationController
  def home
    if user_signed_in?
      @ideas    = current_user.commissions.with_attached_files.limit(3).
                               where(started: false, finished: false)
      @progress = current_user.commissions.with_attached_files.limit(3).
                               where(started: true,  finished: false)
      @unsorted = current_user.commissions.with_attached_files.limit(3).
                               left_outer_joins(:filings).where(finished: true,
                               filings: { commission_id: nil })

      @folders = current_user.folders.includes(:filings).limit(4)

      render 'landing'
    else
      render layout: "no_partials"
    end
  end
end
