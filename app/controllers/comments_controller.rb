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
		# 缺少後端驗證
		if @comment.user != current_user
			flash[:alert] = "你只能修改自己的評論"
			redirect_to issue_path(@issue)
		end
	end

	def update
		@comment = @issue.comments.find(params[:id])
		# 缺少後端驗證
		if @comment.user != current_user
			flash[:alert] = "你只能修改自己的評論"
			redirect_to issue_path(@issue)
		else
			if @comment.update(comment_params)
				redirect_to issue_path(@issue)
			else
				render "edit"
			end
		end
	end

	def destroy
		@comment = @issue.comments.find(params[:id])
		# 缺少後端驗證
		if @comment.user != current_user
			flash[:alert] = "你只能刪除自己的評論"
		else
			@comment.destroy
			flash[:alert] = "event was deleted"
		end
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
