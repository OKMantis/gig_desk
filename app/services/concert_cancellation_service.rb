class ConcertCancellationService < ApplicationService
  def initialize(concert:, reason: "Event cancelled")
    @concert = concert
    @reason = reason
  end

  def call
    return ServiceResult.failure("Concert has already started") unless @concert.upcoming?

    result = @concert.bookings.where(status: "confirmed").map do |booking|
      BookingCancellationService.call(booking: booking, reason: @reason)
    end

    failed = results.select(&:failure?)
    if failed.any?
      return ServiceResult.failure("#{failed.size} refunds failed: #{failed.map(&:error).join(', ')}")
    end

    ServiceResult.success(results.map(&:data))
  end
end