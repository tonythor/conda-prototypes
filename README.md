## using my prototypes project
This project is a working area for building conda packages using pyscaffolding.

1. Git clone this project and conda init your bash or zsh
1. Copy/edit the bash profile into your own.
1. Putup a project like so:
(creates a "tf-ebay" conda project with a source tree like tf.ebay.stuff)
```shell script
putup conda-ebay --package ebay --namespace tf --no-skeleton
```
1. Edit an environment.yml file in the new project to trigger conda. Take
the one from the sample directory.
