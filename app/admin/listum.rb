ActiveAdmin.register Listum do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :nombre, :proveedor_id, :codigo, :descripcion, :precio, :rubro, :hoja, :descuento

  form do |f|
    f.inputs do
      f.input :nombre
      f.input :proveedor_id
	  f.input :codigo
      f.input :descripcion
      f.input :precio
      f.input :rubro
      f.input :hoja , as: :text, input_html: { class: 'jsoneditor-target' }
      f.input :descuento
    end
    f.actions
  end

end
