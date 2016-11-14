class V1::Forms::Response::SectionsController < ApplicationController

	def edit
		respond_with Forms::Response::Section.includes({questions: [{fields: :options}]}).friendly.find(params[:id])
	end

end
