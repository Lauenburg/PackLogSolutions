class Item:

    def __init__(self, id, name, dimensions=[0,0,0], weight=None, prio=None):

        assert len(dimensions) == 3, "dimensions has to be of type: [x, y, z]"
        assert type(id) == int, "id is not an integer: %r" % type(id)
        assert type(name) == str, "name is not a string: %r is of type %r" % (name, type(name))

        self.id = id
        self.name = name
        self.dimensions = dimensions
        self.weight = weight
        self.volume = self.calculate_volume()
        self.prio = None

    def calculate_volume(self):
        return self.dimensions[0] * self.dimensions[1] * self.dimensions[2]