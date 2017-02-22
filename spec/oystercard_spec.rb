require 'oyster_card'
describe OysterCard do
  before(:each) do
    card.top_up(OysterCard::MAXIMUM_BALANCE)
  end
 subject(:card){described_class.new}

	describe "attributes of OysterCard" do
     it "should check the balance" do
     	expect(card.balance).to eq(90)
     end
	end
	describe "top_up of OysterCard" do
		# it{is_expected.to respond_to(:top_up).with(1).argument}

		it 'should raise error if balance>90' do
			error = "Card Limit exceeded"
			#card.top_up(OysterCard::MAXIMUM_BALANCE)
			# p card.balance.to_s + "Balance"
			expect{card.top_up(1)}.to raise_error error
		end

		it "should top up the balance" do
      card = OysterCard.new
			expect{card.top_up(10)}.to change{card.balance}.by 10
		end
	end
	describe 'deductions from oyster card' do

		# it {is_expected.to respond_to(:deduct).with(1).argument}
		#  it 'should raise an error if balance is 0' do
		#  	card.deduct(card.balance-1)
		#  	error = "There is 0 balance on the card"
		#  	expect{card.deduct(1)}.to raise_error error
		#  end
	end

	describe 'in_journey' do
		it {should respond_to(:in_journey?)}
		it {should respond_to(:touch_in?)}
		it {should respond_to(:touch_out?)}

		it "validates that card has the min_amout for journey" do
      card = OysterCard.new
			error = "Card doesn't have sufficiant money"
			expect{card.touch_in?}.to raise_error error
		end
		it 'validates card was not in journey' do
			expect(card).not_to be_in_journey
		end
		# it 'validates card is in journey' do
		# 	card.top_up(OysterCard::MINIMUM_AMOUNT)
		# 	card.touch_in?
		# 	expect(card).to be_in_journey
		# end
		it 'validates that card is deducted on touch out' do
			#card.top_up(OysterCard::MAXIMUM_BALANCE)
			card.touch_in?
			expect{card.touch_out?}.to change{card.balance}.by(-OysterCard::MINIMUM_AMOUNT)
		end

	end
	describe 'entry station' do
		let(:entry_station) { double('Aldgate East')}
		# let(:entry){ :entry_station = !nil}
		it 'confirms card has an entry station on touch_in' do

			#card.top_up(OysterCard::MINIMUM_AMOUNT)
			card.touch_in?(:entry_station)
			expect(card.entry_station).to eq :entry_station
		end
	end

   describe "save old journeys"do
     it "checks that touching out save the journey" do

     card.touch_in?("Liverpool")
      card.touch_out?("Euston")
      expect(card.journey_history).to eq([{"Liverpool" =>"Euston"}])

     end
     it "checks that a new card has an empty journey history" do
       expect(card.journey_history).to be_empty
   end
 end
end
