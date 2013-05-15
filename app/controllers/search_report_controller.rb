class SearchReportController < ApplicationController
	before_filter :init_params

  def index
		domain_id, start_date, end_date = params[:domain_id].to_i, params[:start_date], params[:end_date]
		dates, counts = [], []
		0.upto(@days - 1) do |day|
			current_date = start_date.to_date + day
			report_datas = SearchStatistics.where(["domain_id = ? and created_at between ? and ?", domain_id, current_date.beginning_of_day, current_date.end_of_day])
			dates << current_date.to_time.to_i * 1000
			counts << (report_datas.size > 0 ? report_datas[0].count : 0)
		end
		@datas = Hash[dates.zip(counts)]
	end

	private

		def init_params
  		@domains = Domain.all
			params[:domain_id] = @domains.size > 0 ? @domains[0].id : 0
			params[:start_date] = (Date.today - 11).strftime("%Y-%m-%d") if params[:start_date].blank?
			params[:end_date] = (Date.today - 1).strftime("%Y-%m-%d") if params[:end_date].blank?
			@days = (params[:end_date].to_date - params[:start_date].to_date).to_i + 1
		end

end
