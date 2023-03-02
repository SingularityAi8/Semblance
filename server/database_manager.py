import redis

class DatabaseManager:
    def __init__(self):
        self.redis = redis.Redis(host='localhost', port=6379, db=0)
    
    def set_data(self, key, value):
        self.redis.set(key, value)
    
    def get_data(self, key):
        return self.redis.get(key)
