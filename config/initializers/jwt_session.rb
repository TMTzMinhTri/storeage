JWTSessions.algorithm = 'HS256'
JWTSessions.encryption_key = Rails.application.credentials[:secret_key_base]
JWTSessions.access_exp_time = 6000
JWTSessions.refresh_exp_time = 6000
JWTSessions.csrf_header = 'X-Csrf-Token'
JWTSessions.token_store = :redis, {
  redis_host: ENV['REDIS_HOST'],
  redis_port: ENV['REDIS_PORT'],
  redis_db_name: '0',
  password: ENV['REDIS_PASSWORD'],
  token_prefix: 'session:jwt_'
}
