class ResultBrowseLogsController < ApplicationController
	
	def create
		domain = Domain.find_or_new_by_name(params[:domain])
		respond_to do |format|
			begin
				result_browse_log = domain.result_browse_logs.build(merge_params)
				msg = {}
				if result_browse_log.save
					msg = {:code => 1, :msh => "save success"}
				else
					msg = {:code => -1, :msh => "save fail"}
				end
			rescue
				msg = {:code => -2, :msh => "params format invalid"}
			ensure
				format.json {render :json => msg}
			end
		end
  end

	private
		def merge_params 
			new_params = {
				:visit_id => params[:visit_id],
				:page => params[:page].to_i,
				:position => params[:position].to_i,
				:page_size => params[:page_size].to_i,
				:search_keyword => params[:search_keyword],
				:browser_type => params[:browser_type],
				:created_at => params[:date].to_time
			}
			new_params[:result_position] = (new_params[:page] - 1) * new_params[:page_size] + new_params[:position]
			new_params
		end


end
