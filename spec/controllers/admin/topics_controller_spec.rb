require 'rails_helper'

RSpec.describe Admin::TopicsController, type: :controller do
	describe 'without administrator access' do
		it 'redirects to sign in for non signed users' do
			get :index
			expect(response).to redirect_to(new_user_session_path)
		end

		it 'redirects to root path for non admin users' do
			user = create(:user)
			sign_in user
			get :index
			expect(response).to redirect_to(root_path)
		end
	end

	describe 'with administrator access' do
		let(:valid_attributes) { attributes_for(:topic) }
		let(:invalid_attributes) { attributes_for(:topic, category_id: nil) }
		let(:updated_attributes) { attributes_for(:topic, category_id: 3) }

		before(:each) do
			@topic = create(:topic)
			admin = create(:admin)
			sign_in admin
		end

		describe 'GET #index' do
			it 'renders the index template' do
				get :index
				expect(response).to render_template(:index)
			end

			it 'loads all the topics in the database' do
				get :index
				expect(assigns(:topics)).to eq([@topic])
			end
		end

		describe 'GET #show' do
			it 'renders the show template' do
				get :show, id: @topic
				expect(response).to render_template(:show)
			end

			it 'retrieves a topic from the database' do
				get :show, id: @topic
				expect(assigns(:topic)).to eq(@topic)
			end

			it 'loads the topics comments' do
				topic = create(:topic_with_comments)
				get :show, id: topic
				expect(topic.comments.length).to eq(5)
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

		describe 'PATCH #update' do
			context 'with valid attributes' do
				it 'finds a topic in the database' do
					get :edit, id: @topic
					expect(assigns(:topic)).to eq(@topic)
				end

				it 'updates a topic' do
					category = create(:category)
					updated_topic = attributes_for(:topic, category_id: category.id)
					patch :update, id: @topic, topic: updated_topic
					expect(assigns(:topic).category_id).to eq(category.id)
				end

				it 'redirects to admin topic path' do
					category = create(:category)
					updated_topic = attributes_for(:topic, category_id: category.id)
					patch :update, id: @topic, topic: updated_topic
					expect(response).to redirect_to(admin_topics_path)
				end
			end

			context 'with invalid attributes' do
				it 'does not update a topic' do
					patch :update, id: @topic, topic: invalid_attributes
					expect(@topic.category_id).to_not eq(nil)
				end

				it 're-renders the edit template' do
					patch :update, id: @topic, topic: invalid_attributes
					expect(response).to render_template(:edit)
				end
			end
		end

		describe 'GET #new' do
			it 'renders the new template' do
				get :new
				expect(response).to render_template(:new)
			end

			it 'creates a new topic' do
				get :new
				expect(assigns(:topic)).to be_a_new(Topic)
			end
		end

		describe 'PUT #create' do
			context 'with valid attributes' do
				it 'saves a topic in the database' do
					category = create(:category)
					expect {
						post :create, topic: attributes_for(:topic, category_id: category.id)
					}.to change(Topic, :count).by(1)
				end

				it 'redirects to created topic' do
					category = create(:category)
					post :create, topic: attributes_for(:topic, category_id: category.id)
					expect(response).to redirect_to(admin_topics_path)
				end
			end

			context 'without valid attributes' do
				it 'does not save a topic in the database' do
					expect {
						post :create, topic: invalid_attributes
						}.to_not change(Topic, :count)
				end

				it 're-renders the new template' do
					post :create, topic: invalid_attributes
					expect(response).to render_template(:new)
				end
			end
		end

		describe 'DESTROY #delete' do
			it 'finds a topic in the database' do
				delete :destroy, id: @topic
				expect(assigns(:topic)).to eq(@topic)
			end

			it 'deletes a topic from the database' do
				expect {
					delete :destroy, id: @topic
					}.to change(Topic, :count).by(-1)
			end

			it 'redirects to admin topics index' do
				delete :destroy, id: @topic
				expect(response).to redirect_to(admin_topics_path)
			end
		end
	end
end
