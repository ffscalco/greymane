class EventPresenter < SimpleDelegator
  attr_reader :event

  def initialize(event)
    @event = event
    __setobj__(event)
  end

  def format_start_date
    I18n.l(event.start_date) unless event.start_date.nil?
  end

  def format_start_time
    I18n.l(event.start_time, format: "%H:%M") unless event.start_time.nil?
  end

  def format_end_date
    I18n.l(event.end_date) unless event.end_date.nil?
  end

  def format_end_time
    I18n.l(event.end_time, format: "%H:%M") unless event.end_time.nil?
  end

  def show_event_datetime
    if event.start_date == event.end_date
      "#{I18n.l(event.start_date)} (#{I18n.l(event.start_time, format: "%H:%M")} - #{I18n.l(event.end_time, format: "%H:%M")})"
    else
      "#{I18n.l(event.start_date)} #{I18n.l(event.start_time, format: "%H:%M")} - #{I18n.l(event.end_date)} #{I18n.l(event.end_time, format: "%H:%M")}"
    end
  end
end
