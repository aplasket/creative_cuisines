class Recipe
  attr_reader :url,
              :title,
              :image,
              :country

  def initialize(data, country)
    @url = data[:recipe][:url]
    @title = data[:recipe][:label]
    @image = data[:recipe][:image]
    @country = country
  end
end