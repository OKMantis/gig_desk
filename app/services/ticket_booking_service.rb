class TicketBookingService
  class InsufficientTickets < StandardError; end
  class InsufficientFunds < StandardError; end

  def initialize(concert:, customer:, quantity:)
    @concert = concert
    @customer = customer
    @quantity = quantity
  end

  def call
    return ServiceResult.failure("Quantity must be at least 1") if @quantity < 1
    return ServiceResult.failure("This concert has already happened") unless @concert.upcoming?

    booking = nil

    ActiveRecord::Base.transaction do
      @concert.lock!
      @customer.lock!

      total = @concert.price * @quantity

      raise InsufficientTickets if @concert.tickets_available < @quantity
      raise InsufficientFunds if @customer.credit_balance < total

      @concert.update!(tickets_available: @concert.tickets_available - @quantity)
      @customer.update!(credit_balance: @customer.credit_balance - total)

      booking = Booking.create!(
        concert: @concert,
        customer: @customer,
        quantity: @quantity,
        total_price: total,
        status: "confirmed"
      )
    end

    ServiceResult.success(booking)
  rescue InsufficientTickets
    ServiceResult.failure("Only #{@concert.tickets_available} tickets left")
  rescue InsufficientFunds
    ServiceResult.failure("Insufficient credit balance")
  rescue ActiveRecord::RecordInvalid => e
    ServiceResult.failure(e.message)
  end
end
