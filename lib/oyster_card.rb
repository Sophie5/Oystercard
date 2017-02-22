class OysterCard
	MINIMUM_AMOUNT = 1
	MAXIMUM_BALANCE = 90
	attr_reader :balance, :entry_station, :journey_history
	# attr_accessor :touch_in, :touch_out
	def initialize(balance = 0)
		@balance = balance
		@touch_in = false
		@touch_out = false
		@journey_history = []

	end
		def top_up(amount)
			 if max_balance_limit(amount)
			 	fail "Card Limit exceeded"
			 else
			 	@balance += amount
			 end
		@balance
		end

		def in_journey?
			!!@entry_station
			# @touch_in
		end
		def touch_in?(entry_station = nil)
			if sufficiant_amount?
					@entry_station  = entry_station
					@touch_out = false
					return @touch_in = true

			else
				raise "Card doesn't have sufficiant money"
			end
		end
		def touch_out?(exit_station = nil)
			deduct(MINIMUM_AMOUNT)
			@touch_in = false
			# @exit_station = exit_station
			update_journey_history(exit_station)
			@entry_station = nil
			@touch_out = true
		end

    def update_journey_history(exit_station)
    @journey_history << {entry_station => exit_station}
		end
	private

	def max_balance_limit(amount)
			@balance + amount > MAXIMUM_BALANCE
		end

	def min_balance_limit(amount)
		@balance - amount <= 0
	end
	def sufficiant_amount?
		@balance >= MINIMUM_AMOUNT
	end

	def deduct(amount)
		if  min_balance_limit(amount)
			fail "There is 0 balance on the card"
		else
			@balance -= amount
		end
		@balance
		end
end
