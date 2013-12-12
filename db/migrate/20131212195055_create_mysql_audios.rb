class CreateMysqlAudios < ActiveRecord::Migration
  def change
    create_table :mysql_audios do |t|
      t.string :name
      t.string :attachment

      t.timestamps
    end
  end
end
