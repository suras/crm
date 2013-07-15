module ApplicationHelper
    def get_call_list
    raw current_user.call_lists.to_json
  end
end
