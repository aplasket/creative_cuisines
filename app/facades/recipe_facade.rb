class RecipeFacade
  def initialize(country)
    @country = country
  end

  def recipes
    json = service.get_recipes(@country)
    
    json[:hits].map do |recipe_data|
      Recipe.new(recipe_data, @country)
    end
  end

  def service
    EdamamService.new
  end
end