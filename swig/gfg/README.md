Text from [Wrapping C/C++ using SWIG](https://www.geeksforgeeks.org/wrapping-cc-python-using-swig-set-1/), plus some comments and command output of mine.

We will create wrapper code using the command like `swig -target_language interface_file.i`:

```
swig -python gfg.i
```

After executing this command a wrapper code with name `gfg_wrap.c` is created. This files contains a bloated version of our original C code with various error handling code. Another file `gfg.py` is generated which is the module we will import in our python script.

After this, we have to generate position-independent code (*TODO: what's position independent code?*) which will be used in shared library by compiling “gfg_wrap.c” and “gfg.c” using the following command:

```
sudo apt-get install python-dev
gcc -c -fpic gfg_wrap.c gfg.c -I/usr/include/python2.7
```

Replace python2.7 with your Python version in above command. This will generate two object files
`gfg_wrap.o` and `gfg.o`. To find the correct path of ‘Python.h’ execute following command –

```
python-config --cflags
```

*Tried it and realized it's a good idea to let bash autocomplete `python` by hitting tab. It reveals all versions of `python-config`, among other commands*

Now replace the path in compilation command with this one for python2.7 or change the version as python3.5 for Python 3.5.

*In my case it is python3.6m. Dunno where the 'm' comes from. It works like `gcc -c -fpic gfg_wrap.c gfg.c -I/usr/include/python3.6m`*

Now, at last, we have to link generated objects files together to create a shared object which is analogous to dll files in windows. Use the following command, this will generate a “_gfg.so” shared object file –

```
gcc -shared gfg.o gfg_wrap.o -o _gfg.so
```

Now we are ready to test out python wrapper by importing it. Make sure you are in directory having this wrapper file. 

```
>>> import gfg
>>> res = gfg.fact(5)
>>> res
120
>>> res = gfg.my_mod(5,2)
>>> res
1
>>> gfg.cvar.myvar
3.4
```

*For some reason it doesn't work on IPython but it does on the normal python interpreter, gotta check why.*