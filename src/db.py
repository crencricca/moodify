from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()
class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.String(500), primary_key=True)
    display_name = db.Column(db.String(500), unique=True)
    email = db.Column(db.String(500), unique=True)

    def __init__(self, **kwargs):
        self.id= kwargs.get('id','')
        self.display_name = kwargs.get('display_name','')
        self.email = kwargs.get('email','')
     
    def serialize(self):
            return {
                'id': self.id,
                'display_name': self.display_name,
                'email': self.email,
            }     


class Playlist(db.Model):
    __tablename__ = 'playlist'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.String(500), unique=False)
    name = db.Column(db.String(500), unique=False)
   

    def __init__(self, **kwargs):
        self.user_id = kwargs.get('user_id','')
        self.name = kwargs.get('name','')
        
       
    def serialize(self):
                return {
                    'id': self.id,
                    'user_id': self.user_id,
                    'name': self.name,
                    
                    
                   
                }   