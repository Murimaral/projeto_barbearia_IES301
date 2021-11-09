json.extract! attendance, :id, :title, :description, :start_date, :end_date, :customer_id, :employee_id, :service_id, :created_at, :updated_at
json.url attendance_url(attendance, format: :json)
