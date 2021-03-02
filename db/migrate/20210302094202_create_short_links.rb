class CreateShortLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :short_links do |t|
      t.string :original_url
      t.string :slug
      t.string :timestamps

      t.timestamps
    end
  end
end
