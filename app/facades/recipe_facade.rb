class RecipeFacade
  def initialize(country)
    @country = country
  end

  def recipes
    json = service.get_recipes(@country)

    return nil if json[:hits].empty?

    json[:hits].map do |recipe_data|
      Recipe.new(recipe_data, @country)
    end
  end

  def service
    EdamamService.new
  end
end