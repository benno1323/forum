require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
	let(:valid_attributes) { attributes_for(:category) }
	let(:invalid_attributes) { attributes_for(:category, name: nil) }
	let(:updated_attributes) { attributes_for(:category, name: 'Updated name') }

	before(:each) do
		@category = create(:category)
		@user = create(:user)
		sign_in @user
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
end
