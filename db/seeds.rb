# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count == 0
  User.create({
                  name: 'John',
                  surname: 'Doe',
                  is_active: true,
                  username: 'john@bitcube.co.za',
                  password: 'P@ssw0rd'
              })

  User.create({
                  name: 'Sarah',
                  surname: 'Doe',
                  is_active: true,
                  username: 'sarah@bitcube.co.za',
                  password: 'P@ssw0rd'
              })
  User.create({
                  name: 'Andrew',
                  surname: 'Doe',
                  is_active: true,
                  username: 'andres@bitcube.co.za',
                  password: 'P@ssw0rd'
              })

  User.create({
                  name: 'Anton',
                  surname: 'Doe',
                  is_active: true,
                  username: 'anton@bitcube.co.za',
                  password: 'P@ssw0rd'
              })
end