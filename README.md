#ooc to Javascript experiment

##Why?!
A few weeks ago I discovered the magic that is emscripten and as expected, I was very excited to try it out, especially in combination with ooc.<br/>
I managed to do so with minimal changes to our ooc compiler, rock, which just talks length about the flexibility of ooc thanks to the fact that it targets C.<br/>
<br/>
As to the practical purpose of this experiment... Well, I can't see much of one, apart than using an alternative language you feel more comfortable with rather than Javascript.

##Tools

To compile ooc code to Javascript, I used the following tools

- Clang 3.1
- [emscripten](http://github.com/kripken/emscripten)
- [rock](http://github.com/shamanas/rock)

Note that there is a lightly modified version of rock, the ooc compiler written in ooc, found on the "emscripten" branch of my rock fork.<br/>
The modifications are just a slightly modified version of sdk/lang/Memory.ooc that implements the emscripten GC and a few changes to the default options to compile stuff easier.<br/>
Also, a program named "foo" will automatically generate a file "foo.js" but you can still use the -o option to generatean html file.<br/>

##Compiling

To compile ooc code to Javascript, you will first need to get a working version of Clang (ideally 3.1).<br/>
Then, you should follow the instructions found at [the emscripten homepage](http://emscripten.org) tog et it up and running and add the directory you installed it on to your PATH.<br/>
Last but not least, you must compile the emscripten branch of rock. To do so, just run "make rescue"<br/>
<br/>

Finally, to compile your ooc code that follows the guidelines bellow, you just have to run "rock [filename]"

##Guidelines

For now, I only have one guideline.<br/>
In the start of your main module, you should have the following lines of code:<br/>
<pre lang="ooc">
version(EMSCRIPTEN) {
    include gc
}
// Your code here
</pre>
<br/>
This code is needed to load emscripten's included gc header rather than the modified header that is packed with emscripten-rock and force emcc to include definitions for calloc, malloc and free.<br/>
The reaseon why Memory.ooc does not directly use that header is that it forces a dummy function declaration into the generated object files, so the linker yields an error if you include it in multiple files.<br/>
I am looking for a better solution to this issue and it should not be that difficult, so this guideline will disappear soon.<br/>
Not including this code will not yield an error at compile time but it will at run time.<br/>
<br/><br/>
I have not yet tried to use a C library in an ooc project compiled by emscripten-rock but I do not think it would be complicated.<br/>
In theory, all you have to do is compile the C library using emcc (some guides can be found on their wiki) and the usefile included with the ooc binding should work just fine.<br/>

##Sample

There is a sample file, test.ooc included in this repository, which has been tested and compiled using the method described above.<br/>
I will maybe add a few more samples and try to show off cool features like using the ooc sdl bindings and stuff while I have some free time.<br/>

##Have fun!

Have fun with your ooc generated Javascript folks, that's it for now! \o/
