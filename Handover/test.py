#from sys import get_asyncgen_hooks
#!/usr/bin/env python3
'''
print("Greetings")
name = input("what is your name:\n")

if name == "vanu" or name == "sharmi":
    deeds = int(input("How many good deeds you did today?\n"))
    if deeds < 5:

        print("get out " + name + ", you're not welcome here")
        exit()
    else:
        print("Even you being " + name + ", you did some good no of deed so come in please")
else:
    print("Hello " + name + ", welcome to our shop!!!!")
#menu = "coffee, tee, milk, hotwater"

#item = input("what would you like to have? here are the menus " + menu + "\n")

#print("Thank you for ordering " + item + ", it will be ready is sometimes, please wait")
'''
print("Greeting")
name = input("what is your name:\n")

if name == "vanu" or name == "sharmi":
    deeds = int(input("how many good deeds you did today?\n"))
    if deeds < 5:
        print("get out", name, "you're not welcome here")
    else:
        print("Althought you're being evil, you did some good deeds today, so you're welcome")
else:
    print("Hi", name, "please welcome")

