require 'rails_helper'
require 'yaml'

RSpec.describe "Questionnaires", type: :request do
  let!(:dumy_yaml_folder) {"spec/models/dumy_yamls/"}
  let!(:good_yaml) {File.join(dumy_yaml_folder, 'questionnaire_good.yml')}
  describe "GET /new" do
    it "returns http success" do
      get "/questionnaires/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success after upload" do
      post "/questionnaires", params: {file: good_yaml}
      expect(response).to have_http_status(:found)
    end
  end

end
