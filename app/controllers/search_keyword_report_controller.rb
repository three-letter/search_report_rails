#coding: utf-8

class SearchKeywordReportController < ApplicationController
  before_filter :init_params

  def show
		@domain = Domain.find(params[:domain_id].to_i)
  	keyword_counts = @domain.search_keyword_statisticss.top_count(params[:show_count])
		keywords = keyword_counts.map(&:search_keyword)
		counts = keyword_counts.map(&:search_count)

	  datas = []
		keywords.each_with_index { |keyword, index| datas << {y: counts[index], url: "/keyword_position_report/show?keyword=#{keyword}"} }
		@chart = LazyHighCharts::HighChart.new('graph') do |f|
			f.title({ :text=>"#{@domain.name}"})
			f.options[:xAxis][:categories] = keywords
			f.options[:tooltip][:pointFormat] = "<b>{point.y}</b><br/>点击可查看该词的具体信息"
			f.options[:legend][:layout] = 'horizontal'
			f.series(:type => 'line',:name => 'keyword',
							 :point => {
								     :events => {
													:click => "function(e) {location.href = e.point.url;e.preventDefault();}".js_code
										}
							 },
							 :data=> datas
		 )
		end
	end

	private
		def init_params
			@domains = Domain.all
			params[:show_count] = 10 if params[:show_count].blank?
			params[:domain_id] = @domains[0].id if params[:domain_id].blank?
		end

end



