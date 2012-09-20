require 'spec_helper'

describe Ticket do

  before( :each ) do

    # modify the form to obtain the sequence value and how to create an object Ticket
    @status_ticket = stub_model(StatusTicket)
    @ticket = FactoryGirl.build(:ticket, :status_ticket => @status_ticket)
  end

  it "can be save successfully" do
    @ticket.save.should == true
  end

  it "should be an instance valid if the length of 'value' property is between one and eighty" do
    @ticket.value= 'This is a big text to test a validate for the length of this property.'
    @ticket.should be_valid
  end

  describe "Change of states" do

    before(:all) do
      @status = []
      @status << @status_available = FactoryGirl.create(:status_ticket, :value => "Available")
      @status << FactoryGirl.create(:status_ticket, :value => "Called")
      @status << FactoryGirl.create(:status_ticket, :value => "Canceled")
      @status << FactoryGirl.create(:status_ticket, :value => "Attended")
      @status << FactoryGirl.create(:status_ticket, :value => "Pending")
      @status << FactoryGirl.create(:ticket_type, :acronym => "PRE")

    end

    it "Should initialize with Available State" do
      ticket_new_instance = Ticket.new
      ticket_new_instance.status_ticket.should eq(StatusTicket.available)
    end

    it "Should initialize with open state" do
      @ticket.available?.should be_true
    end

    it "Should allow to change from available state to any other than called " do

      @ticket.cancel.should be_false
      @ticket.recall.should be_false
      @ticket.reopen.should be_false
      @ticket.pending.should be_false
      @ticket.call.should be_true

    end

    it "Should allow to change from called state only to pending or the same" do

      @ticket.call.should be_true
      @ticket.reopen.should be_false
      @ticket.cancel.should be_false
      @ticket.recall.should be_true
      @ticket.pending.should be_true

    end

    it "Should allow to change from pending only to canceled or available" do

      @ticket.call.should be_true
      @ticket.pending.should be_true
      @ticket.call.should be_false
      @ticket.recall.should be_false
      @ticket.reopen.should be_true
      #Redo state to pending to test cancel state
      @ticket.call.should be_true
      @ticket.pending.should be_true
      @ticket.cancel.should be_true

    end

    it "Should not allow to change from canceled to any other" do

      @ticket.call.should be_true
      @ticket.pending.should be_true
      @ticket.cancel.should be_true
      @ticket.call.should be_false
      @ticket.recall.should be_false
      @ticket.reopen.should be_false
      @ticket.pending.should be_false

    end

    describe "Calling next ticket" do

      before( :each ) do
        @ticket_type_group = FactoryGirl.create(:ticket_type_group)
        @ticket_type = FactoryGirl.create(:ticket_type, :priority => true, :ticket_type_group => @ticket_type_group)
        @place = stub_model(Place, :id => "1")
        @tickets = (1..2).collect { FactoryGirl.create(:ticket, :place => @place, :status_ticket_id => @status_available.id, :ticket_type => @ticket_type) }
        @wicket = FactoryGirl.create(:wicket, :ticket_type_group => @ticket_type_group, :place => @place)
      end

      after( :each ) do
        @ticket_type.destroy
      end

      it "Should get the first ticket to be called" do
        ticket_next = Ticket.next_to(@wicket)
        ticket_next.should_not be_nil
        @tickets.include?(ticket_next).should be_true
      end

      it "Should get the next ticket to be called" do
        ticket_first = @tickets.pop
        @tickets.size.should eq(1)
        ticket_first.call.should be_true
        ticket_next = Ticket.next_to(@wicket)
        @tickets.include?(ticket_next).should be_true
      end

      it "Should get the next ticket to be called cause ticket type is priority" do
        pending "WTF is that ? "
        next_ticket = Ticket.next_to(@wicket)
        TicketType.priorities.include?(next_ticket.ticket_type).should be_true
        next_ticket.call
        next_ticket.status_ticket.should be_nil
        other_ticket = Ticket.next_to(@wicket)
        other_ticket.should be_nil
        TicketType.priorities.include?(@ticket_type).should be_true
        TicketType.priorities.should have(2).items
      end

      it "Should not get the next ticket with the same ticket type group to tickets ticket type and wicket" do
        ticket_type_group_one = FactoryGirl.create(:ticket_type_group)
        ticket_type = FactoryGirl.create(:ticket_type, :priority => true, :ticket_type_group => @ticket_type_group)
        TicketType.priorities(ticket_type_group_one).include?(ticket_type).should be_false

        wicket = FactoryGirl.create(:wicket, :ticket_type_group => ticket_type_group_one, :place => @place)
        next_ticket = Ticket.next_to(wicket)

        next_ticket.should be_nil
      end
    end


    describe "Log call history to events of change state" do
      before :each do
        @ticket = FactoryGirl.create(:ticket)
      end

      it "Should save a new record to call_history when change ticket from available to called" do
        @ticket.call.should be_true
        @ticket.called?.should be_true
        @ticket_updated = Ticket.find(@ticket.id)
        @ticket_updated.should_not be_nil
        @ticket_updated.status_ticket.should eq(StatusTicket.id_for("called"))
      end

      it "Should save a new record to call_history when change ticket from called to attending" do
        @ticket.call.should be_true
        @ticket.called?.should be_true
        @ticket.attend.should be_true
        @ticket.attended?.should be_true
        @ticket_updated = Ticket.find(@ticket.id)
        @ticket_updated.should_not be_nil
        @ticket_updated.status_ticket.should eq(StatusTicket.id_for("attended"))
      end

      it "Should save a new record to call_history when change ticket from called to pending" do
        @ticket.call.should be_true
        @ticket.called?.should be_true
        @ticket.pending.should be_true
        @ticket.pending?.should be_true
        @ticket_updated = Ticket.find(@ticket.id)
        @ticket_updated.should_not be_nil
        @ticket_updated.status_ticket.should eq(StatusTicket.id_for("pending"))
      end

    end
  end
end
