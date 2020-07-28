user = User.new
user.username = 't135'
user.email = 't@test.com'
user.password = '123456'
user.save!

admin = Admin.new
admin.email = 'test@test.test'
admin.password = '111111'
admin.save!
