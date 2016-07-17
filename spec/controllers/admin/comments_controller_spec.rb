require 'rails_helper'

RSpec.describe Admin::CommentsController, type: :controller do
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
		let(:valid_attributes) { attributes_for(:comment) }
		let(:invalid_attributes) { attributes_for(:comment, content: nil) }
		let(:updated_attributes) { attributes_for(:comment, topic_id: 1) }

		before(:each) do
			@comment = create(:comment)
			admin = create(:admin)
			sign_in admin
		end

		describe 'GET #index' do
			it 'retrieves a list of comments' do
				get :index
				expect(assigns(:comments)).to eq([@comment])
			end

			it 'renders the index template' do
				get :index
				expect(response).to render_template(:index)
			end
		end

		describe 'GET #show' do
			it 'finds a comment in the database' do
				get :show, id: @comment
				expect(assigns(:comment)).to eq(@comment)
			end

			it 'renders the show template' do
				get :show, id: @comment
				expect(response).to render_template(:show)
			end
		end

		describe 'GET #new' do
			it 'creates a new comment instance' do
				get :new
				expect(assigns(:comment)).to be_a_new(Comment)
			end

			it 'renders the new template' do
				get :new
				expect(response).to render_template(:new)
			end
		end

		describe 'GET #edit' do
			it 'finds a comment in the database' do
				get :edit, id: @comment
				expect(assigns(:comment)).to eq(@comment)
			end

			it 'renders the edit template' do
				get :edit, id: @comment
				expect(response).to render_template(:edit)
			end
		end

		describe 'POST #create' do
			context 'with valid attributes' do
				it 'saves a new comment in the database' do
					topic = create(:topic)
					expect {
						post :create, comment: valid_attributes, topic_id: topic
						}.to change(Comment, :count).by(1)
				end

				it 'redirects to the created comment' do
					topic = create(:topic)
					post :create, comment: valid_attributes, topic_id: topic
					expect(response).to redirect_to(admin_comments_path)
				end
			end

			context 'with invalid attributes' do
				it 'does not save a comment in the database' do
					expect {
						topic = create(:topic)
						post :create, comment: invalid_attributes, topic_id: topic
					}.to_not change(Comment, :count)
				end

				it 're-renders the new template' do
					topic = create(:topic)
					post :create, comment: invalid_attributes, topic_id: topic
					expect(response).to render_template(:new)
				end
			end
		end

		describe 'PATCH #update' do
			context 'with valid attributes' do
				it 'finds a comment in the database' do
					get :edit, id: @comment
					expect(assigns(:comment)).to eq(@comment)
				end

				it 'updates a comment in the database' do
					topic = create(:topic)
					updated_comment = attributes_for(:comment, topic_id: topic.id)
					patch :update, id: @comment, comment: updated_comment
					expect(assigns(:comment).topic_id).to eq(topic.id)
				end

				it 'redirects to admin comments index' do
					topic = create(:topic)
					updated_comment = attributes_for(:comment, topic_id: topic.id)
					patch :update, id: @comment, comment: updated_comment
					expect(response).to redirect_to(admin_comments_path)
				end
			end

			context 'with invalid attributes' do
				it 'does not updates a comment in the database' do
					patch :update, id: @comment, comment: invalid_attributes
					expect(assigns(:comment).topic_id).to_not eq(nil)
				end

				it 're-renders the edit template' do
					patch :update, id: @comment, comment: invalid_attributes
					expect(response).to render_template(:edit)
				end
			end
		end

		describe 'DELETE #destroy' do
			it 'finds a comment in the database' do
				delete :destroy, id: @comment
				expect(assigns(:comment)).to eq(@comment)
			end

			it 'deletes a comment from the database' do
				expect{
					delete :destroy, id: @comment
					}.to change(Comment, :count).by(-1)
			end

			it 'redirects to admin comments index' do
				delete :destroy, id: @comment
				expect(response).to redirect_to(admin_comments_path)
			end
		end
	end
end