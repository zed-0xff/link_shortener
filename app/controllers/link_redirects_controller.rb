class LinkRedirectsController < ApplicationController
  # GET /l/d5e49c8f
  def show
    link = ShortLink.find_by!(slug: params[:slug])

    redirect_to link.original_url
  end
end
