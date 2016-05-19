require 'rails_helper'

describe ContractsController, type: :controller do
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template "layouts/application"
    end
  end
  describe "POST #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
   end
end