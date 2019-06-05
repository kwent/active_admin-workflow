class Sqlite3RepresentBooleanAsInteger < ActiveRecord::Migration[5.2]
  def change
    AdminUser.where("super_admin = 't'").update_all(super_admin: 1)
    AdminUser.where("super_admin = 'f'").update_all(super_admin: 0)
  end
end
