class VoltexCreate<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    create_table(:<%= table_name %>) do |t|
      t.string :name
      t.references :<%= Voltex.role_name %>
      t.timestamps null: false
    end
  end
end
