class Change
  def initialize data
    @data = data
  end

  def add
    {
      add: @data,
      remove: [],
      change: []
    }.to_json
  end

  def remove
    {
      add: [],
      remove: @data,
      change: []
    }.to_json
  end

  def change
    {
      add: [],
      remove: [],
      change: @data
    }.to_json
  end
end
