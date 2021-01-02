class TransportUnit:

    def __init__(self, id, unit_type):
        
        assert type(id) == int, "id is not an integer: %r is of type %r" % (id, type(id))

        self.trans_units = {"container": 4, "small_truck": 2, "truck": 4}

        assert unit_type in self.trans_units.keys(), "unit_type has to be set to one of the following: %r" % (self.trans_units.keys())


        self.id = id
        self.unit_type = unit_type
        self.volume = self.set_volume()
        self.cap_used = 0
        self.cap_free = self.volume
        self.loaded_item_pool = {}


        
    def __repr__(self):
        return str("ID: "+str(self.id)+", Type: "+ self.unit_type)

    def add_cap(self,volume):
        assert ((self.cap_free - volume) > 0)
        assert ((self.cap_used + volume) < self.volume) 
        self.cap_used += volume
        self.cap_free = self.volume - self.cap_used
    
    def set_volume(self):
        return self.trans_units[self.unit_type]