class TransportUnit:

    def __init__(self, id, name=None, volume=0, weight=0):
        
        assert type(id) == int, "id is not an integer: %r is of type %r" % (id, type(id))
        assert type(name) == str, "name is not a string: %r is of type %r" % (name, type(name))

        self.id = id
        self.name = name
        self.volume = volume
        self.weight = weight