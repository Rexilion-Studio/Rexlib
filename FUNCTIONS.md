# RexLib
 A Lua library to make coding easier and more time efficient!
 Rexlib is a free to use, royalty free library, it is very simple to use,
 Rexlib commands look like this:
 Rexlib."commandname(--insert value if needed)"
Rexlib Commands:
  Rexlib.inPercent(value,maxvalue)--returns a percentage
  Rexlib.cloneTable(table)--creates a clone of a table
  Rexlib.wait(seconds)--waits a certain ammount of seconds before running more code, ussualy you want to run it in background using rexlib.runinBackground()--runs function in background
  Rexlib.filter(table to filter,condition to check for for every filtered value)--filters table by condition
  Rexlib.repeatFunction(function to repeat,how many times to repeat)--repeats a function certain ammount of time, if set to -1 it will repeat forever
  Rexlib.removeFromTable(table to remove from,table of things to find and remove)--removes a list of values from a table
  Rexlib.listTable(table)--prints everything inside of the table
  Rexlib.runinBackground(function to run in background)--runs the function in a coroutine, so all other functions can continue
  Rexlib.changed(function that is linked to checking the value,a boolean to be switched uppon value being changed)--bit more complicated, but basicly create a function that will return a value or just use rexlib.getValue, and then put that function inside this function, and it will return a table with boolean saying that the value has been changed once the value changes
  Rexlib.getValue(Value)--returns value, usefull if you need to check value mid loop
Rexlib Managment Comands:
  Rexlib.clearWatchers()--cleans the watcher table, essentialy nuking all current rexlib functions that rely on them, do this only if absolutely neccessary or when shutting down all rexlib funtions at once


This was our first major project, we had to learn throuhg many sources such as github, Ai and other forums so this may not be perfect, but we believe it is good enough to make you save a lot of time in coding

CERTAIN REXLIB FUNCTIONS ARE REQUIRED TO RUN OTHER REXLIB FUNCTIONS!!!

--Made by Seb and Fej
