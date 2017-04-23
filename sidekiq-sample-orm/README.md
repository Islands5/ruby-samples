## sidekiqの開始

```
$bundle exec sidekiq -r ./worker.rb
```

## pyrの準備

```
$bundle exec pry -r ./worker.rb
```

## 実行テスト

```
$ruby main_safe_mongo.rb
$ruby main_unsafe_mongo.rb
$ruby main_safe_mysql.rb
$ruby main_unsafe_mysql.rb
```
