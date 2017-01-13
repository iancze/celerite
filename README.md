**celerite** <br>
\se.le.ʁi.te\ <br>
*noun, archaic literary* <br>
A scalable method for Gaussian Process regression. From French *célérité*. 

--

[![Build Status](http://img.shields.io/travis/dfm/celerite/master.svg?style=flat)](https://travis-ci.org/dfm/celerite)
[![Documentation Status](https://readthedocs.org/projects/celerite/badge/?version=latest&style=flat)](http://celerite.readthedocs.io/en/latest/?badge=latest)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/dfm/celerite/blob/master/LICENSE
)
[![Latest PDF](https://img.shields.io/badge/PDF-latest-orange.svg)](https://github.com/dfm/celerite/blob/master-pdf/paper/ms.pdf)

Implementations of the Generalized Rybicki Press method in C++, Python, and Julia.
This method is an `O(N)` algorithm for solving matrices of the form

```
K_ij = sigma_i^2 delta_ij + sum_p a_p exp(-b_p |t_i - t_j|)
```

and computing their determinants.

See documentation in the `cpp`, `python`, and `julia` subdirectories for usage instructions.

Attribution
-----------

The method was developed by [Sivaram Ambikasaran](https://github.com/sivaramambikasaran>) and you must cite [his paper](http://arxiv.org/abs/1409.7852) if you use this code in your work.

Authors & License
-----------------

Copyright 2016, 2017 Dan Foreman-Mackey, Eric Agol, and contributors.

celerite is free software made available under the MIT License. For details see the LICENSE file.
