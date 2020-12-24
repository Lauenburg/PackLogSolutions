class Item:

    def __init__(self, id, name, dimensions=[0,0,0], weight=None, packing_id=None, quantity=1, max_quantity=1, prio=None):

        assert len(dimensions) == 3, "dimensions has to be of type: [x, y, z]"
        assert type(id) == int, "id is not an integer: %r" % type(id)
        assert type(name) == str, "name is not a string: %r is of type %r" % (name, type(name))

        self.id = id
        self.name = name
        self.dimensions = dimensions
        self.weight = weight
        self.volume = self.calculate_volume()
        self.packing_id = packing_id
        self.quantity = quantity
        self.max_quantity = max_quantity
        self.prio = None

    def calculate_volume(self):
        return self.dimensions[0] * self.dimensions[1] * self.dimensions[2]

    def __repr__(self):
        return str(self.quantity) + " x " + self.name