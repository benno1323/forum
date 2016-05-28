require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do

  describe "GET #index" do
    it "should redirect to root path for non admin users" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

end
