class BookingCancellationService
  def initialize(booking:, reason: "Customer Request")
    @booking = booking
    @reason = reason
  end

  def call
    return ServiceResult.failure("Booking is already cancelled") if @booking.cancelled?
    return ServiceResult.failure("Cannot cancel after the concert has started") unless @booking.concert.upcoming?

    refund = nil

    ActiveRecord::Base.transaction do
      concert = @booking.concert
      customer = @booking.customer
      concert.lock!
      customer.lock!

      concert.update!(tickets_available: concert.tickets_available + @booking.quantity)
      customer.update!(credit_balance: customer.credit_balance + @booking.total_price)
      @booking.update!(status: "cancelled")

      refund = Refund.create!(
        booking: @booking,
        amount: @booking.total_price,
        reason: @reason
      )
    end

    ServiceResult.success(refund)
  rescue ActiveRecord::RecordInvalid => e
    ServiceResult.failure(e.message)
  end
end
