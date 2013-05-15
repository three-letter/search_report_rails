class SearchLogsController < ApplicationController
	
	def create
		domain = Domain.find_or_new_by_name(params[:domain])
		respond_to do |format|
			begin
				search_log = domain.search_logs.build(merge_params)
				msg = {}
				if search_log.save
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
			{
				:visit_id => params[:visit_id],
				:keyword => params[:keyword],
				:search_result_count => params[:search_result_count],
				:browser_type => params[:browser_type],
				:created_at => params[:date].to_time
			}
		end


end
