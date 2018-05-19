# frozen_string_literal: true

json.extract! admin_supplier, :id, :name, :created_at, :updated_at
json.url admin_supplier_url(admin_supplier, format: :json)
