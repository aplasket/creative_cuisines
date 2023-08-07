class CityAir
  attr_reader :aqi,
              :pm25_concentration,
              :co_concentration

  def initialize(data, capital)
    @aqi = data[:overall_aqi]
    @pm25_concentration = data[:"PM2.5"][:concentration]
    @co_concentration = data[:CO][:concentration]
  end
end