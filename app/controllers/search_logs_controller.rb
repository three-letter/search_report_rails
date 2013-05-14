class SearchLogsController < ApplicationController
	
	def create
		domain_name = params[:domain]
		domain = Domain.new({:name => domain_name})
		domain = Domain.find_by_name(domain_name) if Domain.exist?(domain_name)
		domain.save
		respond_to do |format|
			begin
				search_log = domain.search_logs.build(merge_params(params))
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
		def merge_params ps
			{
				:visit_id => ps[:visit_id],
				:keyword => ps[:keyword],
				:search_result_count => ps[:search_result_count],
				:browser_type => ps[:browser_type],
				:created_at => ps[:date].to_time
			}
		end


end
