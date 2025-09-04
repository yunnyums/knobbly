class Config:
    SECRET_KEY  = 'JKJOWEOAd<tbh+d.nOiUHBigIhi¿GHigIOjHouPOi--mvckdbanoucbYVTv8yb9ygIYg7t7302fHF82¿'
    GEBUG   = True
    
class DevelopmentConfig(Config):
    MYSQL_HOST      = 'localhost'
    MYSQL_USER      = 'root'
    MYSQL_PASSWORD  = 'mysql'
    MYSQL_DB        = 'knobbly'

config = {
    'development': DevelopmentConfig
}