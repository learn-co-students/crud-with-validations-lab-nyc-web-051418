class Song < ActiveRecord::Base
  validates :title, presence: true
  validate :no_duplicate_titles_in_same_year
  validate :has_release_year_if_released
  validate :no_future_release_date

  def no_duplicate_titles_in_same_year
    if !Song.where(title: title, release_year: release_year).empty?
      errors.add(:title, "cannot release two songs with the same title in the same year")
    end
  end

  def no_future_release_date
    if released && release_year && release_year > Time.new.year
      errors.add(:release_year, "released albums cannot have a release date in the future")
    end
  end

  def has_release_year_if_released
    if released == true && !release_year
      errors.add(:release_year, "released albums must have a release year")
    end
  end
end
