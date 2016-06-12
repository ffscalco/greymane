require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:valid_attributes) {
    {
      :name => "Awesome Event",
      :local => "Somewhere",
      :price => "25.99",
      :site => "awesome_event.com",
      :subject => "This awesome event is about awesomeness",
      :start_date => "2016-06-02",
      :start_time => "13:00:00",
      :end_date => "2016-06-02",
      :end_time => "18:00:00"
    }
  }

  let(:invalid_attributes) { {name: ""} }

  before do
    sign_in(FactoryGirl.create(:user))
  end

  describe "GET #index" do
    it "assigns all events of the current_user team as @events" do
      event = FactoryGirl.create(:event, valid_attributes.merge({team_id: controller.current_user.team.id}))
      event2 = FactoryGirl.create(:event, valid_attributes.merge({team_id: controller.current_user.team.id}))
      event3 = FactoryGirl.create(:event, valid_attributes)

      get :index, {}
      expect(Event.all.size).to eq(3)
      expect(assigns(:events)).to match_array([event, event2])
    end

    it "order the events by start_date and start time" do
      event1 = FactoryGirl.create(:event, valid_attributes.merge({team_id: controller.current_user.team.id}))
      event2 = FactoryGirl.create(:event, start_date: "2016-06-02", start_time: "09:00:00", team_id: controller.current_user.team.id)
      event3 = FactoryGirl.create(:event, start_date: "2016-06-01", start_time: "09:00:00", team_id: controller.current_user.team.id)

      get :index, {}
      expect(assigns(:events)).to eq([event3, event2, event1])
    end
  end

  describe "GET #new" do
    it "assigns a new event as @event" do
      get :new, {}
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe "GET #edit" do
    it "assigns the requested event as @event" do
      event = FactoryGirl.create(:event, valid_attributes)
      get :edit, {:id => event.to_param}
      expect(assigns(:event)).to eq(event)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Event" do
        expect {
          post :create, {:event => valid_attributes}
        }.to change(Event, :count).by(1)
      end

      it "assigns a newly created event as @event" do
        post :create, {:event => valid_attributes}
        expect(assigns(:event)).to be_a(Event)
        expect(assigns(:event)).to be_persisted
      end

      it "assigns the current user team into event" do
        post :create, {:event => valid_attributes}

        expect(assigns(:event).team).to eq(controller.current_user.team)
      end

      it "redirects to the event index" do
        post :create, {:event => valid_attributes}
        expect(response).to redirect_to(events_path)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        post :create, {:event => invalid_attributes}
        expect(assigns(:event)).to be_a_new(Event)
      end

      it "re-renders the 'new' template" do
        post :create, {:event => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {price: "100,00"}
      }

      it "updates the requested event" do
        event = FactoryGirl.create(:event, valid_attributes)

        put :update, {:id => event.to_param, :event => new_attributes}
        event.reload
        expect(event.price.to_s).to eq("100.0")
      end

      it "assigns the requested event as @event" do
        event = FactoryGirl.create(:event, valid_attributes)

        put :update, {:id => event.to_param, :event => new_attributes}
        expect(assigns(:event)).to eq(event)
      end

      it "redirects to the event index" do
        event = FactoryGirl.create(:event, valid_attributes)

        put :update, {:id => event.to_param, :event => new_attributes}
        expect(response).to redirect_to(events_path)
      end
    end

    context "with invalid params" do
      it "assigns the event as @event" do
        event = FactoryGirl.create(:event, valid_attributes)

        put :update, {:id => event.to_param, :event => invalid_attributes}
        expect(assigns(:event)).to eq(event)
      end

      it "re-renders the 'edit' template" do
        event = FactoryGirl.create(:event, valid_attributes)

        put :update, {:id => event.to_param, :event => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested event" do
      event = FactoryGirl.create(:event, valid_attributes)

      expect {
        delete :destroy, {:id => event.to_param}
      }.to change(Event, :count).by(-1)
    end

    it "redirects to the events list" do
      event = FactoryGirl.create(:event, valid_attributes)

      delete :destroy, {:id => event.to_param}
      expect(response).to redirect_to(events_url)
    end
  end

end
