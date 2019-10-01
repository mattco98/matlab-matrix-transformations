# matlab-matrix-transformation

This library provides and easy way to create SO(3) and SE(3) matrix transformations using a clean and concise API. Supported transformations include translation and rotation, both local and global, in any arbitrary order.

The library provides most functionality through the `Transformation` class, which contains the methods for doing the various supported transformations. `Transformation` methods return `TransformationBuilder` instances, a builder-style class for creating arbitrarily long chains of transformations.

## Examples

#### Compute SE(3) rotation matrices

In order to calculate a rotation, we start by calling `Translation.rotate()`, followed by the particular rotations.

```matlab
>> Transformation.rotate().glob().x(1.1 * pi).y(3 * pi / 2).z(1.34).matrix()

ans =

   -0.0000    0.9965   -0.0833         0
   -0.0000    0.0833    0.9965         0
    1.0000    0.0000    0.0000         0
         0         0         0    1.0000
```

The call to `.glob()` sets the reference mode to global, meaning all three of the above rotations are relative to the global frame.

In degrees:

```matlab
>> Transformation.rotate().glob().xd(198).yd(270).zd(76.7763).matrix()

ans =

   -0.0000    0.9965   -0.0833         0
   -0.0000    0.0833    0.9965         0
    1.0000    0.0000    0.0000         0
         0         0         0    1.0000
```

The `xd`, `yd`, and `zd` functions behave exactly as their respective radian functions do with regards to local and global rotations, however you must be in rotation mode to use these functions, otherwise an error will be thrown.

#### Compute axes angles

With the same rotations in the examples above:

```matlab
>> [k, theta] = Transformation.rotate().glob().xd(198).yd(270).zd(76.7763).axis()

k =

   -0.5606
   -0.6094
   -0.5606


theta =

    2.0470
```

#### Local rotations

Compute local rotations:

```matlab
>> Transformation.rotate().loc().xd(198).yd(270).zd(76.7763).matrix()

ans =

   -0.0000    0.0000   -1.0000         0
   -0.8551   -0.5184   -0.0000         0
   -0.5184    0.8551    0.0000         0
         0         0         0    1.0000
```

#### Combine local and global rotations

Local and global rotations can be calculated in any arbitrary order

```matlab
>> Transformation.rotate().loc().xd(30).yd(12).glob().zd(180).loc().x(pi / 2).matrix()

ans =

   -0.9781   -0.2079    0.0000         0
   -0.1040    0.4891    0.8660         0
   -0.1801    0.8471   -0.5000         0
         0         0         0    1.0000
```

When combining local and global rotations, the order you call the functions is the order they are applied in. So the above matrix represents the following rotations:

1. Rotating 30 degrees around the local x axis
2. Rotating 12 degrees around the local y axis
3. Rotating 180 degrees around the global z axis
4. Rotating pi / 2 radians around the local x axis

Normally you would have to reorder these operations in order to compute the actual transformation matrix, but this is handled automatically by the library.

#### Translation

Compute SE(3) translation matrices

```matlab
>> Transformation.translate().x(12).y(-2).z(87).matrix()

ans =

     1     0     0    12
     0     1     0    -2
     0     0     1    87
     0     0     0     1
```


#### Rotation and Translation

Rotations and Translations can be combined arbitrarily and in either reference frame.

```matlab
>> Transformation.rotate().z(pi).translate().x(-10).matrix()

ans =

   -1.0000   -0.0000         0   10.0000
    0.0000   -1.0000         0   -0.0000
         0         0    1.0000         0
         0         0         0    1.0000
```

Note that there are no calls to `.loc()` or `.glob()`. The call to `Transformation.rotate()` or `Transformation.translate()` automatically sets the reference frame to local.

This can be seen by comparing the above local transformation to an equivalent transformation in a global coordinate frame:

```matlab
>> Transformation.rotate().glob().z(pi).translate().x(10).matrix()

ans =

   -1.0000   -0.0000         0   10.0000
    0.0000   -1.0000         0         0
         0         0    1.0000         0
         0         0         0    1.0000
```

As expected, the transformation matrices are identical. Note that the local/global reference frame will always carry through `.rotate()` and `.translate()` calls, meaning there is no need to re-call `.glob()` after the call to `.translate()`.

And of course, any of these functions can be combined with each other to perform some quite lengthy transformations

```matlab
>> Transformation.translate().x(10).z(10).rotate().xd(90).glob().z(pi / 2).translate().loc().y(2).matrix()

ans =

    0.0000   -0.0000    1.0000    0.0000
    1.0000    0.0000   -0.0000   10.0000
         0    1.0000    0.0000   12.0000
         0         0         0    1.0000
```

As a sidenote, the pure rotation matrix can be obtained from an SE(3) transformation matrix by calling `.matrix3()` instead of `.matrix()`.

#### Multiple transformations for one frame

All of the builder methods take a matrix as an argument, allowing easy calculation of multiple transformation matrices for the same reference frame. For completeness, the list of builder methods are the following:

- `Transformation.rotate(matrix)`
- `Transformation.translate(matrix)`
- `Rotation.loc(matrix)`
- `Rotation.glob(matrix)`
- `Translation.builder(matrix)` & `Translation.loc(matrix)` & `Translation.glob(matrix)`

You can store the builder from any of these methods and use it to operate on the same `matrix`.

#### Automatic application of transformation matrices

The matrix methods (i.e. `RotationBuilder.matrix()`, `RotationBuilder.matrix3()`, and `TranslationBuilder.matrix()`) take a `target` argument which, if provided, will automatically be applied to the transformation matrix. The result of the multiplication will be returned.
