class AirQualitySerializer
  # include JSONAPI::Serializer

  # set_id { nil }
  # set_type :air_quality
  # attributes  :city,
                # :aqi,
                # :pm25_concentration,
                # :co_concentration


  def initialize(data, city)
    @aqi = data.aqi
    @pm25_concentration = data.pm25_concentration
    @co_concentration = data.co_concentration
    @city = city
  end

  def serialized_json
    {
      data: {
        id: nil,
        type: "air_quality",
        city: @city,
        attributes: {
          aqi: @aqi,
          pm25_concentration: @pm25_concentration,
          co_concentration: @co_concentration
        }
      }
    }
  end
end