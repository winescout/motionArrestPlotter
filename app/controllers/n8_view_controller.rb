METERS_PER_MILE = 1609.344

class N8ViewController < UIViewController
  attr_accessor :delegate, :refreshTapped, :mapView

  def viewDidLoad
    super
  end

  def viewWillAppear(animated)
    latitude = 39.281516
    longitude = -76.580806
    zoom_location = CLLocationCoordinate2D.new(latitude, longitude)
    viewRegion = MKCoordinateRegionMakeWithDistance(zoom_location, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    mapView.setRegion(viewRegion, animated: true)
  end

  def plotCrimePositions(response_data)
    mapView.annotations.each do |annotation|
      mapView.removeAnnotation(annotation)
    end

    response_data["data"].each do |row|
      latitude = row[21][1].to_f
      longitude = row[21][2].to_f
      crimeDescription = row[17]
      address = row[13]
      coordinate = CLLocationCoordinate2D.new(latitude, longitude)
      annotation = N8MyLocation.init_with_name(crimeDescription, address:address, coordinate:coordinate)
      mapView.addAnnotation(annotation)
    end
  end

  def refreshTapped(sender)
    map_region = mapView.region
    center_location = map_region.center
    request = BW::JSON.generate (
      {
          "originalViewId" =>"3i3v-ibrt",
          "name" =>"Inline View",
          "query" =>{
              "filterCondition" =>{
                  "type" =>"operator",
                  "value" =>"WITHIN_CIRCLE",
                  "children" =>[ {
                              "type" =>"column",
                              "columnFieldName" => "location_1"
                              }, {
                              "type" =>"literal",
                              "value" => center_location.latitude
                              }, {
                              "type" =>"literal",
                              "value" => center_location.longitude
                              }, {
                              "type" =>"literal",
                              "value" => 0.5*METERS_PER_MILE
                              } ]
              }
          }
      }
    ) 

    url = "http://data.baltimorecity.gov/api/views/INLINE/rows.json?method=index"
    BW::HTTP.post(url, {payload: request, headers:{"Content-Type"=>"application/json"}}) do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        plotCrimePositions(json)
      else
        App.alert(response.error_message)
      end
    end 
  end
end
