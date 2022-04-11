# Fantasy Game Inventory
# by: Tim Lupien
# originally written c. 11/2021

# a function to print the inventory in a specific way
def displayInventory(inventory):
   print("Inventory:")
   item_total = 0
   for k, v in inventory.items():
       print(str(v) + ' ' + str(k))
       item_total += v
   print("Total number of items: " + str(item_total))

# a function using setdefault to add items to the inventory
def addToInventory(inventory, addedItems):
   for i in range(len(addedItems)):
       inventory.setdefault(addedItems[i],0)
       inventory[addedItems[i]] += 1
   return inventory

# test
print("Original state of inventory:\n")
stuff = {'rope': 1, 'torch': 6, 'gold coin': 42, 'dagger': 1, 'arrow': 12}
displayInventory(stuff)

print("\nLoot added.\n")
dragonLoot = ['gold coin', 'dagger', 'gold coin', 'gold coin', 'ruby']
stuff = addToInventory(stuff, dragonLoot)

print("New state of inventory:\n")
displayInventory(stuff)