# d-utils
Useful modules for dlang.  

## BitArray:
`import d.util.bits`

`BitArray` has been written to store bits in a small array rather than an array of 8 byte elements.  Storing a bool on an 8 byte element would take up more memory than is needed to store bits.  It may be renamed to `bitfield` instead, eventually.  It is self initialized, and to assign a variable with a bitarray or bitfield, you can use `BitField!`{number of bits}` `{variable name}.  You can then set a bit to either true or false using {variable name}`[`{index of bit}`]= `{`true`|`false` value}, or retrieve the true or false value like with {variable name}`[`{index}`]`.  

## Multi dimensional array:
`import d.util.array`

These are tensors aka multidimensional arrays in programming.  They are data-structures that can handle 2D, and even 3D arrays.  `Array!`{type}`(`{X}`, `{Y}`)` gives you a 2 dimensional array.  Same goes with 3 dimensional arrays (`Array!`{type}`(`{X}`, `{Y}`, `{Z}`)`).  
