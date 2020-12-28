class TransportUnit:

    def __init__(self, id, name=None, volume=0, weight=0):
        
        assert type(id) == int, "id is not an integer: %r is of type %r" % (id, type(id))
        assert type(name) == str, "name is not a string: %r is of type %r" % (name, type(name))

        self.id = id
        self.name = name
        self.volume = volume
        self.weight = weight
        self.cap_used = 0
        self.cap_free = volume
        self.loaded_item_pool = {}
        
    def __repr__(self):
        return str("ID: "+str(self.id)+", Name: "+ self.name)

    def add_cap(self,volume):
        assert ((self.cap_free - volume) > 0)
        assert ((self.cap_used + volume) < self.volume) 
        self.cap_used += volume
        self.cap_free = self.volume - self.cap_used