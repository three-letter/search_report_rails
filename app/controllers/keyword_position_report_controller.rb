class KeywordPositionReportController < ApplicationController
  before_filter :init_params
	
	def show
		@domain = Domain.find(params[:domain_id].to_i)	
		keyword_position_counts = @domain.keyword_position_statisticss.keyword_records(params[:keyword]).date_records(params[:date].to_date)
		positions = keyword_position_counts.map(&:position)
		counts = keyword_position_counts.map(&:count)

		@chart = LazyHighCharts::HighChart.new('graph') do |f|
			f.title({ :text=>"#{@domain.name} - #{params[:keyword]} -#{params[:date]} "})
			f.options[:xAxis][:categories] = positions
			f.options[:legend][:layout] = 'horizontal'
			f.series(:type=> 'line',:name=> 'keyword position',:data=> counts)
		end
  end

	private

		def init_params
			@domains = Domain.all
			params[:date] = (Date.today - 1).strftime("%Y-%m-%d") if params[:date].blank?
			params[:domain_id] = @domains[0].id if params[:domain_id].blank?
			params[:keyword] = "qq"  if params[:keyword].blank?
		end
end
