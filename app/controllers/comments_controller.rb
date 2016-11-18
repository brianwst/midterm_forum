class CommentsController < ApplicationController
	before_action :find_issue
	def new
		@comment = @issue.comments.build 
	end

	def create
		@comment = @issue.comments.new( comment_params )
		@comment.user = current_user

		if @comment.save 
			flash[:notice] = "Comment created"	
			redirect_to issue_path(@issue)
		else
			render 'new'
		end
	end

	def edit
		@comment = @issue.comments.find(params[:id])
	end

	def update
		@comment = @issue.comments.find(params[:id])
		if @comment.update(comment_params)
			redirect_to issue_path(@issue)
		else
			render "edit"
		end

	end

	def destroy
		@comment = @issue.comments.find(params[:id])
		@comment.destroy
		flash[:alert] = "event was deleted"

		redirect_to issue_path(@issue)
	end

	private
	def find_issue
		@issue = Issue.find(params[:issue_id])
	end

	def comment_params 
		params.require(:comment).permit(:content)
	end
end
