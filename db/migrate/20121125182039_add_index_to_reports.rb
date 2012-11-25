class AddIndexToReports < ActiveRecord::Migration
  def change
    add_index :reports, [ :reportable_id, :reportable_type ]
  end
end
