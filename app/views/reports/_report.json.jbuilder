json.extract! report, :id, :stat_id, :value, :last_edit_by, :department_id, :created_at, :updated_at
json.url report_url(report, format: :json)
