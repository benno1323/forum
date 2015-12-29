require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
	describe 'GET #index' do
		it 'renders the index template' do
			get :index
			expect(response).to render_template(:index)
		end

		it 'assigns a list of categories' do
			cat_1 = create(:category)
			cat_2 = create(:category)
			get :index
			expect(assigns(:categories)).to eq([cat_1, cat_2])
		end
	end

	describe 'GET #show' do
		it 'renders the show template' do
			category = create(:category)
			get :show, id: category
			expect(response).to render_template(:show)
		end

		it 'retrieves a category from the database' do
			category = create(:category)
			get :show, id: category
			expect(assigns(:category)).to eq(category)
		end
	end

	describe 'GET #edit' do
		it 'retrieves a category from the database' do
			category = create(:category)
			get :edit, id: category
			expect(assigns(:category)).to eq(category)
		end

		it 'renders the edit template' do
			category = create(:category)
			get :edit, id: category
			expect(response).to render_template(:edit)
		end
	end

	describe 'GET #new' do
		it 'renders the new template' do
			get :new
			expect(response).to render_template(:new)
		end

		it 'creates a new category' do
			get :new
			expect(assigns(:category)).to be_a_new(Category)
		end
	end

	describe 'POST #create' do
		context 'with valid attributes' do
			it 'saves a category in the database' do
				expect{
					post :create, category: attributes_for(:category)
					}.to change(Category, :count).by(1)
			end

			it 'redirects to categories#index' do
				post :create, category: attributes_for(:category)
				expect(response).to redirect_to(categories_url)
			end
		end

		context 'with invalid attributes' do
			it 'does not save a category in the database' do
				expect{
					post :create,
						category: attributes_for(:category, name: nil)
					}.to_not change(Category, :count)

			end

			it 're-renders the new template' do
				post :create,
						category: attributes_for(:category, name: nil)
				expect(response).to render_template(:new)
			end
		end
	end

	describe 'PATCH #update' do
		context 'with valid attributes' do
			it 'retrieves a category from the database' do
				category = create(:category)
				get :edit, id: category
				expect(assigns(:category)).to eq(category)
			end

			it 'changes a category attribute' do
				category = create(:category)
				patch :update, id: category,
					category: attributes_for(:category, name: 'Updated Name')
				category.reload
				expect(assigns(:category).name).to eq('Updated Name')
			end

			it 'redirects to the updated category' do
				category = create(:category)
				patch :update, id: category,
					category: attributes_for(:category, name: 'Updated Name')
				expect(response).to redirect_to(category)
			end
		end

		context 'with invalid attributes' do
			it 'does not changes a category attribute' do
				category = create(:category)
				patch :update, id: category,
					category: attributes_for(:category, name: nil)
				category.reload
				expect(category.name).to_not eq(nil)
			end

			it 're-renders the edit template' do
				category = create(:category)
				patch :update, id: category,
					category: attributes_for(:category, name: nil)
				category.reload
				expect(response).to render_template(:edit)
			end
		end

		describe 'DELETE #destroy' do
			it 'retrieves a category from the database' do
				category = create(:category)
				delete :destroy, id: category
				expect(assigns(:category)).to eq(category)
			end

			it 'deletes a category from the database' do
				category = create(:category)
				expect{
					delete :destroy, id: category
					}.to change(Category, :count).by(-1)
			end

			it 'redirects to category#index' do
				category = create(:category)
				delete :destroy, id: category
				expect(response).to redirect_to(categories_url)
			end
		end
	end
end
