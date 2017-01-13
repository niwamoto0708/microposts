
# Twitter クローン課題評価用 seed
#
#User.destroy_all

u1 = User.new(name: "hashimoto", email: "hashimoto@helloinc.jp", password: "password")
u1.save(validate: false)

u2 = User.new(name: "test", email: "test@example.com", password: "password")
u2.save(validate: false)

N_USER = 80

users = []

(1..N_USER).each do |i|
  u = User.new(name: "test#{i}", email: "example#{i}@example.com")
  u.password = 'hogehoge'
  u.save!(validate: false)
  users << u
end

u3 = users[2]

# Rails は Module#const_missing で動的にモデルクラスを読み込むため、とりあえずは呼んでみる
begin
  Micropost.destroy_all
rescue
end
begin
  Relationship.destroy_all
rescue
end

# 課題ごとにクラスがあるかないかを判定
do_micropost = Kernel.const_defined? :Micropost
do_follow = Kernel.const_defined? :Relationship

begin
  if do_micropost
    (1..20).each do |i|
      print '+'
      Micropost.create(user: u1, content: "テストメッセージ\nその#{i}")
    end

    (1..20).each do |i|
      print '+'
      Micropost.create(user: u2, content: "テストメッセージ\nTEST@EXAMPLE.COM\nその#{i}")
    end
  end

  if do_micropost
    (1..20).each do |i|
      print '+'
      Micropost.create(user: u3, content: "テストメッセージ\n#{u1.email}\nその#{i}")
    end
  end

  if do_follow
    (3..60).each do |i|
      print '-'
      u = users[i]
      u2.follow(u)
      u.follow(u2)
    end

    (4..(N_USER-1)).each do |i|
      print '/'
      u = users[i]
      u3.follow(u)
      u.follow(u3)
    end
  end

  if do_micropost
    (1..20).each do |i|
      Micropost.create(user: u3, content: "テストメッセージ\nサンプルです。\nその#{i}")
    end
  end
end

puts "\n--> OK"
