class Recipe
  def initialize(data)
    @url = data[:recipe][:url]
    @label = data[:recipe][:label]
    @image = data[:recipe][:image]
  end
end