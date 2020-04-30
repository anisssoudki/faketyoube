class CreateUsersTable < ActiveRecord::Migration[6.0]
  def change

      create_table :users do |t|
        t.string :name 
        t.string :email 
        t.string :password_digest   #use password digest works with bycrypt gem in order to encrypt the password, we can now call has_secure_password on our user model


      end
    end
end
