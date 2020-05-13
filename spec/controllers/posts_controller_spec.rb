require 'rails_helper'
describe PostsController do
  describe 'GET #new' do
    it "new.html.hamlに遷移します" do
      get :new
      expect(response).to render_template :new
    end
  end
  
end