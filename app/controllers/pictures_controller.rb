class PicturesController < ApplicationController

  def index
    last_month = DateTime.current.prev_month
    @most_recent_pictures = Picture.most_recent_five
    @old_pictures = Picture.created_before(last_month)
    @jin_nian_pictures = Picture.pictures_created_in_year(Time.new.year)
    @pictures = Picture.all


  end

  def self.old_pictures
    Post.where("created_at >= ?", 1.week.ago.utc).order("votes_count DESC, created_at DESC")
  end

  # def index
  #   @pictures = Picture.all
  # end

  def show
    @picture = Picture.find(params[:id])
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]

    if @picture.save
      # if the picture gets saved, generate a get request to "/pictures" (the index)
      redirect_to "/pictures"
    else
      # otherwise render new.html.erb
      render :new
    end

  end


  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])

    @picture.title = params[:picture][:title]
    @picture.artist = params[:picture][:artist]
    @picture.url = params[:picture][:url]

    if @picture.save
      # if the picture gets saved, generate a get request to "/pictures" (the index)
      redirect_to "/pictures/#{@picture.id}"
    else
      # otherwise render new.html.erb
      render :edit
    end
  end


  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to "/pictures"
  end

end
