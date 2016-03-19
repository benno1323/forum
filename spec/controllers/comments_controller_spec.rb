require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
	describe 'POST #create' do
		let(:valid_attributes) { attributes_for(:comment) }
		let(:invalid_attributes) { attributes_for(:comment, content: nil) }

		before(:each) do
			@topic = create(:topic)
			@user = create(:user)
			sign_in @user
		end

		context 'with valid attributes' do
			it 'saves a comment in the database' do
				expect {
					post :create, topic_id: @topic,
						comment: valid_attributes
					}.to change(Comment, :count).by(1)
			end

			it 'redirects to notes#show' do
				post :create, topic_id: @topic,
					comment: valid_attributes
				expect(response).to redirect_to(@topic)
			end
		end

		context 'with invalid attributes' do
			it 'does not save a comment in the database' do
				expect {
					post :create, topic_id: @topic,
						comment: invalid_attributes
					}.to change(Comment, :count).by(0)
			end

			it 're-renders the notes#show template' do
				post :create, topic_id: @topic,
					comment: invalid_attributes
				expect(response).to render_template('topics/show')
			end
		end
	end
end
