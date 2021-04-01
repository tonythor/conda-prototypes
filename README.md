## using my prototypes project
This project is a working area for building conda packages using pyscaffolding.

### 1. Git clone this project and conda init your bash or zsh.
### 2. Copy/edit the bash profile into your own.
### 3. Putup a project like so: 
(creates a "tf-ebay" conda project with a source tree like tf.ebay.stuff)
```shell script
putup tf-ebay --package ebay --namespace tf --no-skeleton
```
### 4. Edit an environment.yml file in the ebay directory for conda to activate on. Take the one from from the samples directory. 
