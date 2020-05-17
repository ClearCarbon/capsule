class CreatePodcasts < ActiveRecord::Migration[6.0]
  def change
    create_table :podcasts do |t|
      t.string :title
      t.string :url
      t.text :description
      t.string :language
      t.string :subtitle
      t.string :author
      t.string :image_url
      t.string :category
      t.string :owner_name
      t.string :owner_email

      t.timestamps
    end
  end
end
