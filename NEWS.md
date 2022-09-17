# ASGS 2021.0

## Breaking user visible changes
  * Due to deprecation of `rgdal` etc, objects are now `sf`. 
  * Relatedly, objects are no longer lazyloaded, instead being available by 
    calls. So instead of `SA2_2016` one uses `SA2_2016()`.

* Add 2021 shapefiles, including at the meshblock level
* 

# ASGS 0.4.0

* Added a `NEWS.md` file to track changes to the package.
