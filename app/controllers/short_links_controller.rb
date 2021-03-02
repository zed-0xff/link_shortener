class ShortLinksController < ApplicationController
  # GET /short_links/1
  def show
    @short_link = ShortLink.find(params[:id])
  end

  # GET /short_links/new
  def new
    @short_link = ShortLink.new
  end

  # POST /short_links
  def create
    @short_link = ShortLink.new(short_link_params)

    if @short_link.save
      redirect_to @short_link, notice: 'Short link was successfully created.'
    else
      render :new
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def short_link_params
      params.require(:short_link).permit(:original_url)
    end
end
