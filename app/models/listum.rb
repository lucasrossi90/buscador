class Listum < ActiveRecord::Base
	belongs_to :proveedor
  has_many :articulos

  validates :proveedor, presence: true
end
