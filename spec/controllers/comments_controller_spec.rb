require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "comments#create action" do
    it "should allow users to create comments on grams" do
      gram = FactoryGirl.create(:gram)
      u = FactoryGirl.create(:user)
      sign_in u
      post :create, gram_id: gram.id, comment: { message: "nice gram" }
      expect(response).to redirect_to root_path
      expect(gram.comments.length).to eq 1
      expect(gram.comments.first.message).to eq "nice gram"
    end

    it "should require a user to be logged in to comment on a gram" do
      gram = FactoryGirl.create(:gram)
      post :create, gram_id: gram.id, comment: { message: "nice gram" }
      expect(response).to redirect_to new_user_session_path
    end

    it "should return http status code 404 if the gram isn't found" do
      u = FactoryGirl.create(:user)
      sign_in u
      post :create, gram_id: 'loafcat', comment: { message: "ERGLEDERP" }
      expect(response).to have_http_status(:not_found)
    end
  end
end
