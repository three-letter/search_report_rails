class SearchLog < ActiveRecord::Base
  attr_accessible :browser_type, :domain_id, :keyword, :search_result_count, :visit_id
end
