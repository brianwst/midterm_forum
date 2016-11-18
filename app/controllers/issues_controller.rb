class IssuesController < ApplicationController
	before_action :find_post, only: [:show, :edit, :destroy, :update ]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@issues = Issue.all
	end

	def new
		@issue = Issue.new
	end

	def show
	end

	def create
		@issue = Issue.new(issue_params)

		if @issue.save
			redirect_to issue_path(@issue)
		else
			render "new"
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
		params.require(:issue).permit(:title, :content)
	end
end

