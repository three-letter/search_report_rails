class ResultBrowseLogsController < ApplicationController
	
	def create
		domain_name = params[:domain]
		domain = Domain.new({:name => domain_name})
		domain = Domain.find_by_name(domain_name) if Domain.exist?(domain_name)
		domain.save
		respond_to do |format|
			begin
				result_browse_log = domain.result_browse_logs.build(merge_params(params))
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
		def merge_params ps
			new_params = {
				:visit_id => ps[:visit_id],
				:page => ps[:page].to_i,
				:position => ps[:position].to_i,
				:page_size => ps[:page_size].to_i,
				:search_keyword => ps[:search_keyword],
				:browser_type => ps[:browser_type],
				:created_at => ps[:date].to_time
			}
			new_params[:result_position] = (new_params[:page] - 1) * new_params[:page_size] + new_params[:position]
			new_params
		end


end
