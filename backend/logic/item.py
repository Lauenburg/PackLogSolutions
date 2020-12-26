class Item:

    def __init__(self, id, name, dimensions=[0,0,0], weight=None, packing_id=None, quantity=1, max_quantity=None,
                client_id=None, order_id=None, date=None, out_date=None, prio=None):

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
        self.prio = prio
        self.client_id = client_id
        self.order_id = order_id
        self.date = date
        self.out_date = out_date

    @ classmethod
    def from_item_query(clc, sql_item, quantity = 1, client_id=None, order_id=None, date=None, out_date=None, prio=None):
        ''' Class mehtod used to initialize new class instances given an item query by DataManager.getArticle(item_id)
            
            Input: 
                sql_item = item query tuple retrived by the data manager's getArticle function
                quantity: Ordered quantity of an item

            Return: 
                Item instance
        '''
        assert isinstance(sql_item, tuple)
        
        # retrive information from query tupel
        item_id, name, l, b, h, weight, pack_id, max_quant = sql_item

        return Item(item_id, name, dimensions=[l, b, h], weight=weight, packing_id=pack_id, max_quantity=max_quant,
                client_id=client_id, order_id=order_id, date=date, out_date=out_date, prio=prio)
    

    def calculate_volume(self):
        return self.dimensions[0] * self.dimensions[1] * self.dimensions[2]

    def __repr__(self):
        return str(self.quantity) + " x " + self.name