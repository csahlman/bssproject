class AddSummaryToIdioms < ActiveRecord::Migration
  def change
    add_column :idioms, :summary, :string
  end
end
