class Holiday
  attr_reader :name

  def initialize(holiday)
    @name = holiday[:localName]
  end
end
