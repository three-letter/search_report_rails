class PositionReportController < ApplicationController
  before_filter :init_params
	
	def show
		@domain = Domain.find(params[:domain_id].to_i)	
		position_counts = @domain.position_statisticss.date_records(params[:date].to_date)
		positions = position_counts.map(&:position)
		counts = position_counts.map(&:count)

		@chart = LazyHighCharts::HighChart.new('graph') do |f|
			f.title({ :text=>"#{@domain.name} -#{params[:date]} "})
			f.options[:xAxis][:categories] = positions
			f.options[:legend][:layout] = 'horizontal'
			f.series(:type=> 'line',:name=> 'position',:data=> counts)
		end
  end

	private

		def init_params
			@domains = Domain.all
			params[:date] = (Date.today - 1).strftime("%Y-%m-%d") if params[:date].blank?
			params[:domain_id] = @domains[0].id if params[:domain_id].blank?
		end
end
