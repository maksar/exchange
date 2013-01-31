class Stock < Struct.new :name, :count
  def to_json _
    {
      name: name,
      count: count,
      price: 42 # TODO to a.shestakov Place current price here.
    }.to_json
  end
end
