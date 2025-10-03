class Config:
    SECRET_KEY  = 'hfirdnlfdnesljfnslhdu45hhgtguk38w4847664773irsh7673mjf'
    DEBUG       = True
    
class DevelopmentConfig(Config):
    MYSQL_HOST  = 'localhost'
    MYSQL_USER  = 'root'
    MYSQL_PASSWORD  = 'mysql'
    MYSQL_DB    = 'errores'

config ={
        'development': DevelopmentConfig
        
    }