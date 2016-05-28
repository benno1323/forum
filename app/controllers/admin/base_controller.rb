class Admin::BaseController < ApplicationController
	layout 'admin'
	before_action :authenticate_user!

	private
		def authenticate_admin
			redirect_to root_path, notice: "Not authorized" unless current_user.admin?
		end
end
