require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
	let(:valid_attributes) { attributes_for(:topic) }
	let(:invalid_attributes) { attributes_for(:topic, subject: nil, body: nil) }
	let(:updated_attributes) { attributes_for(:topic, subject: 'Updated subject',
																						body: 'Updated body') }

	before(:each) do
		@topic = create(:topic)
		@user = create(:user)
		sign_in @user
	end

	describe 'GET #index' do
		it 'renders the index template' do
			get :index, category_id: @topic.category_id
			expect(response).to render_template(:index)
		end

		it 'assigns a list of topics' do
			get :index, category_id: @topic.category_id
			expect(assigns(:topics)).to eq([@topic])
		end
	end

	describe 'GET #show' do
		it 'renders the show template' do
			get :show, id: @topic
			expect(response).to render_template(:show)
		end

		it 'assigns a topic to be shown' do
			get :show, id: @topic
			expect(assigns(:topic)).to eq(@topic)
		end
	end

	describe 'GET #edit' do
		it 'renders the edit template' do
			get :edit, id: @topic
			expect(response).to render_template(:edit)
		end

		it 'retrieves a topic from the database' do
			get :edit, id: @topic
			expect(assigns(:topic)).to eq(@topic)
		end
	end

	describe 'GET #new' do
		it 'renders the new template' do
			get :new, category_id: @topic.category_id
			expect(response).to render_template(:new)
		end

		it 'assigns a new topic' do
			get :new, category_id: @topic.category_id
			expect(assigns(:topic)).to be_a_new(Topic)
		end
	end

	describe 'POST #create' do
		context 'with valid attributes' do

			it 'saves a new topic to the database' do
				expect {
					post :create, topic: valid_attributes, category_id: @topic.category_id
				}.to change(Topic, :count).by(1)
			end

			it 'redirects to the show view' do
				post :create, topic: valid_attributes, category_id: @topic.category_id
				expect(response).to redirect_to(assigns(:topic))
			end
		end

		context 'with invalid attributes' do
			it 're-renders the new template' do
				post :create, topic: invalid_attributes, category_id: @topic.category_id
				expect(response).to render_template(:new)
			end
		end
	end

	describe 'PATCH #update' do
		context 'with valid attributes' do
			it 'finds a topic in the database' do
				get :edit, id: @topic, category_id: @topic.category_id
				expect(assigns(:topic)).to eq(@topic)
			end

			it 'updates a topic in the database' do
				patch :update, id: @topic, category_id: @topic.category_id,
					topic: updated_attributes
				@topic.reload
				expect(assigns(:topic).subject).to eq('Updated subject')
				expect(assigns(:topic).body).to eq('Updated body')
			end

			it 'redirects to the show view' do
				patch :update, id: @topic, category_id: @topic.category_id,
					topic: updated_attributes
				expect(response).to redirect_to(assigns(:topic))
			end
		end

		context 'with invalid attributes' do
			it 'does not change a topic attributes' do
				patch :update, id: @topic, category_id: @topic.category_id,
					topic: invalid_attributes
				@topic.reload
				expect(@topic.subject).to_not eq('Updated subject')
				expect(@topic.body).to_not eq(nil)
			end

			it 're-renders the edit template' do
				patch :update, id: @topic, category_id: @topic.category_id,
					topic: invalid_attributes
				expect(response).to render_template(:edit)
			end
		end
	end

	describe 'DELETE #destroy' do
		it 'deletes a topic from the database' do
			expect{
				delete :destroy, id: @topic
			}.to change(Topic, :count).by(-1)
		end

		it 'redirects to topics#index' do
			delete :destroy, id: @topic
			expect(response).to redirect_to(topics_url)
		end
	end
end
