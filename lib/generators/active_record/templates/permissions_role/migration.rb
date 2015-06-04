class VoltexCreate<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    create_table(:<%= table_name %>) do |t|
      t.references :<%= Voltex.permission_name %>
      t.references :<%= Voltex.role_name %>
    end
  end
end
