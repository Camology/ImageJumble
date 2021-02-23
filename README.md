# ImageJumble

Lets you scramble up an image into NxO chunks, takes 4 parameters:
* first: input file name+extension
* second: output file name+extension
* third: horizontal chunk size
* fourth: vertical chunk size

Requires: imagemagick (youll be prompted to install it if you dont have it)

Sample usage: ```./imageJumble.sh candyman.jpg candymanJumbled.jpg 4 4  ```

Based mostly on two scripts found here:
https://stackoverflow.com/questions/28142106/how-to-cut-image-into-pieces-randomize-them-and-put-all-together

and here: https://stackoverflow.com/questions/1298066/check-if-an-apt-get-package-is-installed-and-then-install-it-if-its-not-on-linu
