class HolidayFacade

  def self.get_holidays
    all_holidays = HolidayService.find_holidays
    all_holidays.shift(3).map do |holiday|
      Holiday.new(holiday)
    end
  end
end
