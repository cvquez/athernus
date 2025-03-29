class AddShowInHomepageToQuestionnaires < ActiveRecord::Migration[7.0]
  def change
    add_column :questionnaires, :show_in_homepage, :boolean, default: false
    add_index :questionnaires, :show_in_homepage
  end
end
