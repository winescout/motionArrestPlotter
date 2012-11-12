class N8MyLocation
  attr_accessor :name, :address, :the_coordinate

  def self.init_with_name(name, address: address, coordinate: coordinate)
    my_location = N8MyLocation.new
    my_location.name = name
    my_location.address = address
    my_location.the_coordinate = coordinate
    return my_location
  end

  def title
    self.name
  end

  def subtitle
    self.address
  end

  def coordinate
    self.the_coordinate
  end
end