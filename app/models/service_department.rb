class ServiceDepartment < ApplicationRecord
	belongs_to :service
	belongs_to :department
end
