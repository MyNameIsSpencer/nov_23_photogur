class Picture < ApplicationRecord
  def self.newest_first
    Picture.order("created_at DESC")
  end

  def self.most_recent_five
    Picture.newest_first.limit(5)
  end

  def self.created_before(time)
    Picture.where("created_at < ?", time)
  end

  def self.pictures_created_in_year(year)
    Picture.where(created_at: Time.new(year)..Time.new(year + 1))
    # Picture.where(created_at: Time.new(year)..Time.new(year +1))
  end

end
