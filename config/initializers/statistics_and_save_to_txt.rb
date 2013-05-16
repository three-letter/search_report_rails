require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new

scheduler.cron("30 1 * * *") do
	SearchLog.save_to_txt(Date.today - 1)
	SearchLog.statistics_search_by_date(Date.today - 1)
	SearchLog.statistics_search_keyword_by_date(Date.today - 1)

	ResultBrowseLog.save_to_txt(Date.today - 1)
	ResultBrowseLog.statistics_position_by_date(Date.today - 1)
	ResultBrowseLog.statistics_keyword_position_by_date(Date.today -1)
end
