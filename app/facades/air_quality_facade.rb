class AirQualityFacade
  def initialize(capital)
    @capital = capital
  end

  def air_quality
    json = NinjaService.new.get_air_quality(@capital)
    CityAir.new(json)
  end
end