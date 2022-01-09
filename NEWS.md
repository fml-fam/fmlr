# Release 0.4-0 (//)

New:
  * Moved fml headers to separate fmlh package.
  * Updated to fmlh 0.4-1:
      - Added `linalg_dot()`
      - Added `linalg_trinv()`
      - Added `linalg_rsvd()`

API Changes:
  * `linalg_matmult()` can now accept mixed matrix/vector arguments.
  * Renamed `linalg_tssvd()` to `linalg_qrsvd()`.

Bug Fixes:
  * Fixed gpu/mpi bug on norm/cond dispatch.

Documentation: None

Internal Changes of Note from Latest fml Release:
  * Changed gpumat crossprod() and tcrossprod() to use Xgemm() instead of
    Xsyrk() for better run-time performance.
  * Switched linalg::qr_Q() and linalg::lq_Q() to use `Xorgqr()`/`Xorglq()` except in gpumat lq_Q().





# Release 0.3-0 (9/6/2020)

New:
  * Updated to fml v. 0.3-0:
      - Added min/max methods for cpuvec and gpuvec.
      - Added norm functions `linalg_norm_1()`, `linalg_norm_I()`,
        `linalg_norm_F()`, `linalg_norm_M()`, and `linalg_norm_2()`.
      - Added condition number functions `linalg_cond_1()`, `linalg_cond_I()`, 
        and `linalg_cond_2()`.

API Changes: None

Bug Fixes:
  * See fml 0.3-0 release.

Documentation: None





# Release 0.2-1-1 (9/2/2020)

New:
  * Building with MPI backend support is now optional, and disabled by default. Enable by adding `--enable-mpi` to the package configure args (Mac, Linux), or modifying Makevars.win appropriately. This is explained in-depth in the installation guide.
  * Fixed installation issues for Windows.
  * GPU backend now available for Windows.
  * Added more benchmarks (`inst/benchmarks/`).
  * Added `synch()` method for card objects to force a synchronization.

API Changes: None

Bug Fixes:
  * Safer .NAME usage in .Call() internals.
  * Added more exception guards.

Documentation:
  * Clarified some things in the installation guide.
  * Added Windows GPU instructions.





# Release 0.2-1 (5/29/2020)

New:
  * Added linalg bindings:
      - linalg_qr()
      - linalg_qr_Q()
      - linalg_qr_R()
      - linalg_lq()
      - linalg_lq_L()
      - linalg_lq_Q()
      - linalg_tssvd()
      - linalg_cpsvd()
      - linalg_chol()
  * Added dimops bindings:
      - dimops_rowsums()
      - dimops_rowmeans()
      - dimops_colsums()
      - dimops_colmeans()
      - dimops_scale()
  * Added stats bindings:
      - stats_pca()
  * Added mpihelpers bindings:
      - cpu2mpi()

API Changes: None

Bug Fixes:
  * Added Makevars.win.
  * Updated cpu `inherit()` methods and all class `from_robj()` methods (and
    correspondingly, `as_*()` methods) to accept double, int, and float data.
  * `as_*()` functions now choose return type based on the R object input.

Documentation:
  * Added vignettes:
      - installation
      - basic overview
      - backend management
      - data management
  * Added vignettes to pkgdown docs.





# Release 0.1-0 (2/5/2020)

New:
  * Added bindings for cpumat and cpuvec classes
  * Added bindings for gpumat and gpuvec classes
  * Added bindings for mpimat class
  * Added linalg bindings:
      - linalg_add()
      - linalg_matmult()
      - linalg_crossprod()
      - linalg_tcrossprod()
      - linalg_xpose()
      - linalg_lu()
      - linalg_svd()
      - linalg_eigen_sym()
      - linalg_invert()
      - linalg_solve()
  * Added cpuhelpers bindings:
      - cpu2cpu()
  * Added gpuhelpers bindings:
      - gpu2cpu()
      - cpu2gpu()
      - gpu2gpu()
  * Added mpihelpers bindings:
      - mpi2cpu()
      - mpi2mpi()

API Changes: None

Bug Fixes: None

Documentation:
  * Added documentation for most things.
