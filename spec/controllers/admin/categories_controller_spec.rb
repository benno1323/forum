require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
	let(:valid_attributes) { attributes_for(:category) }
	let(:invalid_attributes) { attributes_for(:category, name: nil) }
	let(:updated_attributes) { attributes_for(:category, name: 'Updated name') }

	it 'should redirect to sign in path for non signed users' do
		get :index
		expect(response).to redirect_to(new_user_session_path)
	end

	it 'should redirect to root path for non admin users' do
		user = create(:user)
		sign_in user
		get :index
		expect(response).to redirect_to(root_path)
	end

	describe 'administrator acces' do
		before :each do
			@category = create(:category)
			admin = create(:admin)
			sign_in admin
		end

		describe 'GET #index' do
			it 'renders the index template' do
				get :index
				expect(response).to render_template(:index)
			end

			it 'assigns a list of categories' do
				get :index
				expect(assigns(:categories)).to eq([@category])
			end
		end

		describe 'GET #show' do
			it 'renders the show template' do
				get :show, id: @category
				expect(response).to render_template(:show)
			end

			it 'retrieves a category from the database' do
				get :show, id: @category
				expect(assigns(:category)).to eq(@category)
			end
		end

		describe 'GET #edit' do
			it 'renders the edit template' do
				get :edit, id: @category
				expect(response).to render_template(:edit)
			end

			it 'retrieves a category from the database' do
				get :edit, id: @category
				expect(assigns(:category)).to eq(@category)
			end
		end

		describe 'POST #new' do
			it 'renders the new template' do
				get :new
				expect(response).to render_template(:new)
			end

			it 'creates a new category instance' do
				get :new
				expect(assigns(:category)).to be_a_new(Category)
			end
		end

		describe 'POST #create' do
			context 'with valid attributes' do
				it 'saves a category in the database' do
					expect {
						post :create, category: valid_attributes
					}.to change(Category, :count).by(1)
				end

				it 'redirects to categories#index' do
					post :create, category: valid_attributes
					expect(response).to redirect_to(admin_categories_path)
				end
			end

			context 'with invalid attributes' do
				it 'does not save a category in the database' do
					expect{
						post :create, category: invalid_attributes
					}.to_not change(Category, :count)
				end

				it 're-renders the new template' do
					post :create, category: invalid_attributes
					expect(response).to render_template(:new)
				end
			end
		end

		describe 'PATCH #update' do
			context 'with valid attributes' do
				it 'finds a category in the database' do
					get :edit, id: @category
					expect(assigns(:category)).to eq(@category)
				end

				it 'updates a category' do
					patch :update, id: @category, category: updated_attributes
					@category.reload
					expect(assigns(:category).name).to eq('Updated name')
				end

				it 'redirects to admin categories path' do
					patch :update, id: @category, category: updated_attributes
					expect(response).to redirect_to(admin_categories_path)
				end
			end

			context 'with invalid attributes' do
				it 'does not update a category' do
					patch :update, id: @category, category: invalid_attributes
					@category.reload
					expect(assigns(:category).name).to_not eq('Updated name')
				end

				it 're-renders the edit template' do
					patch :update, id: @category, category: invalid_attributes
					@category.reload
					expect(response).to render_template(:edit)
				end
			end
		end

		describe 'DELETE #destroy' do
			it 'finds a category in the database' do
				delete :destroy, id: @category
				expect(assigns(:category)).to eq(@category)
			end

			it 'deletes a category from the database' do
				expect {
					delete :destroy, id: @category
				}.to change(Category, :count).by(-1)
			end

			it 'redirects to admin categories path' do
				delete :destroy, id: @category
				expect(response).to redirect_to(admin_categories_path)
			end
		end
	end
end