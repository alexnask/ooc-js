version(EMSCRIPTEN) {
    include gc // Must be included in main module once :)
}
import structs/ArrayList
// Do some trick to avoid version-including gc once...

"Hello World!" println()
[1, 2, 3, 4, 5] as ArrayList<Int> map(|num| num * 2) each(|num|
    num toString() println()
)
