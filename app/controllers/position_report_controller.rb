#coding: utf-8

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

		if position_counts.size > 20
			pie_positions = ["1", "2-5", "6-10", "10-20", "大于20"]
			pie_counts = [counts[0], counts[1,4].inject {|c1,c2| c1 + c2}, counts[5,5].inject{|c1,c2| c1 + c2}, counts[10,10].inject{|c1,c2| c1 + c2}, counts[20]] 
			pie_datas = [] 
			pie_positions.each_with_index do |pos, index|
				pie_datas[index] = [pos, pie_counts[index]]	
			end
			@pie_chart = LazyHighCharts::HighChart.new('graph') do |f|
				f.title({ :text=>"#{@domain.name} - #{params[:date]} - pie"})
				f.plotOptions({
					:pie => {
						:dataLabels => { 
							:format => "{point.name}: <b>{point.percentage}%</b>" }}	
				})
				f.series(:type=> 'pie',:name=> 'count',:data=> pie_datas)
			end
		end
  end

	private

		def init_params
			@domains = Domain.all
			params[:date] = (Date.today - 1).strftime("%Y-%m-%d") if params[:date].blank?
			params[:domain_id] = @domains[0].id if params[:domain_id].blank?
		end
end
