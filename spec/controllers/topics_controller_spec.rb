require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
	describe 'GET #index' do
		it 'renders the index template' do
			get :index
			expect(response).to render_template(:index)
		end

		it 'assigns a list of topics' do
			get :index
			topic_one = create(:topic)
			topic_two = create(:topic)
			topics = [topic_one, topic_two]
			expect(assigns(:topics)).to eq(topics)
		end
	end

	describe 'GET #show' do
		it 'renders the show template' do
			topic = create(:topic)
			get :show, id: topic.id
			expect(response).to render_template(:show)
		end

		it 'assigns a topic to be shown' do
			topic = create(:topic)
			get :show, id: topic.id
			expect(assigns(:topic)).to eq(topic)
		end
	end

	describe 'GET #edit' do
		it 'renders the edit template' do
			topic = create(:topic)
			get :edit, id: topic
			expect(response).to render_template(:edit)
		end

		it 'retrieves a topic from the database' do
			topic = create(:topic)
			get :edit, id: topic
			expect(assigns(:topic)).to eq(topic)
		end
	end

	describe 'GET #new' do
		it 'renders the new template' do
			get :new
			expect(response).to render_template(:new)
		end

		it 'assigns a new topic' do
			get :new
			expect(assigns(:topic)).to be_a_new(Topic)
		end
	end

	describe 'PUT #create' do
		context 'with valid attributes' do

			it 'saves a new topic to the database' do
				expect {
					post :create, topic: attributes_for(:topic)
				}.to change(Topic, :count).by(1)
			end

			it 'redirects to the show view' do
				post :create, topic: attributes_for(:topic)
				expect(response).to redirect_to(assigns(:topic))
			end
		end

		context 'with invalid attributes' do
			it 're-renders the new template' do
				post :create, topic: attributes_for(:topic, body: nil)
				expect(response).to render_template(:new)
			end
		end
	end

	describe 'PATCH #update' do
		before(:each) do
			@topic = create(:topic)
		end

		context 'with valid attributes' do
			it 'finds a topic in the database' do
				get :edit, id: @topic
				expect(assigns(:topic)).to eq(@topic)
			end

			it 'updates a topic in the database' do
				patch :update, id: @topic,
					topic: attributes_for(:topic, body: 'New body')
				@topic.reload
				expect(assigns(:topic).body).to eq('New body')
			end

			it 'redirects to the show view' do
				patch :update, id: @topic,
					topic: attributes_for(:topic, body: 'New body')
				expect(response).to redirect_to(assigns(:topic))
			end
		end

		context 'with invalid attributes' do
			it 'does not change a topic attributes' do
				patch :update, id: @topic,
					topic: attributes_for(:topic, subject: 'Updated subject', body: nil)
				@topic.reload
				expect(@topic.subject).to_not eq('Updated title')
				expect(@topic.body).to_not eq(nil)
			end

			it 're-renders the edit template' do
				patch :update, id: @topic,
					topic: attributes_for(:topic, body: nil)
				expect(response).to render_template(:edit)
			end
		end
	end

	describe 'DELETE #destroy' do
		it 'deletes a topic from the database' do
			topic = create(:topic)
			expect{
				delete :destroy, id: topic
			}.to change(Topic, :count).by(-1)
		end

		it 'redirects to topics#index' do
			topic = create(:topic)
			delete :destroy, id: topic
			expect(response).to redirect_to(topics_url)
		end
	end
end
