# CL-SPATIAL-HASH-GRID

This library allows the easy object oriented usage of a spatial hash grid for 2 dimensions. 

## Roadmap

The following check list shows what is already done and what is up next.

- [x] Define the data structure 
- [x] Insert entities into the data structure
- [x] Remove entities from the data structure
- [x] Query the data structure to find entites
- [ ] Bug fixes and performance boosts

## Tutorial

To create a spatial hash grid we just have to do

```lisp
(defvar *shg* (make-spatial-hash-grid 1))
```
(The parameter given to the MAKE-SPATIAL-HASH-GRID constructor function is the cell size of the grid, cells are always squares.)

after we created the spatial hash grid we can now insert entites like this

```lisp
(shg-insert *shg* (make-entitiy '(0 0) '(5 5)))
```
(The parameters given to the MAKE-ENTITY constructor function are the position [in X and Y coordinates] of the bottom left corner of the bounding box and the dimensions [in width and height] of the box.)

now we can find the entities and remove them again (if we want).

```lisp
(shg-find *shg* '(0 0) '(5 5))
(shg-remove *shg* (first (shg-find *shg* '(0 0) '(5 5))))
```
(The parameters of SHG-FIND are the same as the one for MAKE-ENTITY. They describe a bounding box and every entity inside this bounding box  returned in a list. The SHG-REMOVE function removes a given entity, the above call removes the first entity returned by SHG-FIND.)

That's all this library is able to do, and it's all the library should be able to do. It would be possible to add some utility functions for easier access but most of the things should be straight forward. 

## Final Paragraph

If some things are unclear or stuff is broken please hit me with an issue, I'm more than happy to fix stuff. :)
