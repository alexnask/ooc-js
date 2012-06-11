version(EMSCRIPTEN) {
    include gc // Must be included in main module once. TODO: Find someway to remove this "dependency"
    include emscripten

    runScript: extern(emscripten_run_script) func(CString)
}
import structs/ArrayList
import os/Time

"Hello World!" println()
[1, 2, 3, 4, 5] as ArrayList<Int> map(|num| num * 2) each(|num|
    num toString() println()
)

try {
    [0][1] // Trigger an exception!
} catch {
    "CAUGHT THAT!" println()
}

"\n" times(2) println()

5 times(||
    "javascript array test (counted and called from ooc): %d milliseconds" format(Time measure(||
        runScript("\
        var array = new Array(); \
        for(i = 0; i < 100; i++) { \
            array[i] = i; \
        } \
        for(i = 0; i < 100; i++) { \
            array[i] = array[99 - i]; \
        } \
        ")
    )) println()

    "ooc array test: %d milliseconds" format(Time measure(||
        array := ArrayList<Int> new(100)
        for(i in 0 .. 100) {
            array add(i)
        }

        for(i in 0 .. 100) {
            array[i] = array[99 - i]
        }
    )) println()
)

