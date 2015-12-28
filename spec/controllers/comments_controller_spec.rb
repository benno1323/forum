require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
	describe 'POST #create' do
		context 'with valid attributes' do
			it 'saves a comment in the database' do
				topic = create(:topic)
				expect {
					post :create, topic_id: topic,
						comment: attributes_for(:comment)
					}.to change(Comment, :count).by(1)
			end

			it 'redirects to notes#show' do
				topic = create(:topic)
				post :create, topic_id: topic,
					comment: attributes_for(:comment)
				expect(response).to redirect_to(topic)
			end
		end

		context 'with invalid attributes' do
			it 'does not save a comment in the database' do
				topic = create(:topic)
				expect {
					post :create, topic_id: topic,
						comment: attributes_for(:comment, content: nil)
					}.to change(Comment, :count).by(0)
			end

			it 're-renders the notes#show template' do
				topic = create(:topic)
				post :create, topic_id: topic,
					comment: attributes_for(:comment, content: nil)
				expect(response).to render_template('topics/show')
			end
		end
	end
end
