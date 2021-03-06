# # Example of custom field
# # add it this way: log_tags << lambda { |req| get_user_id(req) }
# def get_user_id(req)
#   session = ActiveRecord::SessionStore::Session.find_by_session_id(req.cookie_jar["_AppBounty_session"])
#   result = session ? session.data["user_id"].to_i : 0

#   "%07d" % result
# end

log_tags = []
log_tags << lambda { |req| Time.now.strftime("%F %T.%L") }
log_tags << lambda { |req| req.uuid.first(8) }

Rails.configuration.log_tags = log_tags