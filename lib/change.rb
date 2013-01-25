class Change
  def initialize data
    @data = data
  end

  def add
    {
      add: @data,
      remove: []
    }.to_json
  end

  def remove
    {
      add: [],
      remove: @data
    }.to_json
  end
end
