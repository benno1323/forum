require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do

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

	describe 'GET #index' do
		context 'when admin signed in' do
			it 'renders the index template' do
				user = create(:user)
				user.role = 2
				sign_in user
				get :index
				expect(response).to render_template(:index)
			end

			it 'assigns a list of categories' do
				admin = attributes_for(:user, role: 2)
				sign_in admin
				category = create(:category)
				expect(assigns(:categories)).to eq([category])
			end
		end
	end

	describe 'GET #show' do
		it 'renders the show template'
		it 'retrieves a category from the database'
	end

	describe 'GET #edit' do
		it 'renders the edit template'
		it 'retrieves a category from the database'
	end

	describe 'POST #new' do
		it 'renders the new template'
		it 'creates a new category instance'
	end

	describe 'POST #create' do
		context 'with valid attributes' do
			it 'saves a category in the database'
			it 'redirects to categories#index'
		end

		context 'with invalid attributes' do
			it 'does not save a category in the database'
			it 're-renders the new template'
		end
	end
end