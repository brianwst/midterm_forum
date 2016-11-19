class IssuesController < ApplicationController
	before_action :find_post, only: [:show, :edit, :destroy, :update ]
	before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

	def index
		#never all!
		@issues = Issue.page(params[:page]).includes(:user)
	end

	def new
		@issue = current_user.issues.build
	end

	def show
		@comment = Comment.new
		#never all!
		@comments = @issue.comments.includes(:user).page(params[:page])
	end

	def create
		@issue = current_user.issues.build(issue_params)

		if @issue.save
			redirect_to issue_path(@issue)
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @issue.update(issue_params)
			redirect_to issue_path(@issue)
		else
			render "edit"
		end
	end

	def destroy
		@issue.destroy
		redirect_to issues_path

	end

	private
	def find_post
		@issue = Issue.find(params[:id])
	end

	def issue_params
		params.require(:issue).permit(:title, :content, :category_id)
	end
end


