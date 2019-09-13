#!/bin/bash
# Inspired by my BatchWatermark script
#Shell script that applies a batch of ingredients to their respective random pizza bases.

## Description:
# Selects a random pizza from the pizzas folder
# For each ingredient, creates a new pizza !


## Instructions:
#  - Drag script in a folder of your choice
#  - Run the script, I use the Windows Subsystem for Linux (WSL) command prompt.
#  - The script should generate 2 files: PIZZAS and INGREDIENTS.
#  - Place your pizzas in PIZZAS
#  - Place ingredients in INGREDIENTS
#  - Run the script a second time, it should place the ingredients on random pizza bases.
  
## Dependencies:
# Requires Imagemagick https://imagemagick.org/script/download.php



# Path of the folder containing the script:
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
	PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

	PIZZAS=$DIR"/Pizzas"
	INGREDIENTS=$DIR"/Ingredients"
	FINISHEDPIZZA=$DIR"/FinishedPizzas"
	INITIALISED=true
	
# Create folder to place the pizza images.
	if [ ! -d $PIZZAS ]; then
	  mkdir -p $PIZZAS;
	  $INITIALISED = false 
	fi
	
# Create folder to place the ingredients images.
	if [ ! -d $INGREDIENTS ]; then
	  mkdir -p $INGREDIENTS;
	  $INITIALISED = false
	fi
	
# Create folder to place the FINISHEDPIZZA images.
	if [ ! -d $FINISHEDPIZZA ]; then
	  mkdir -p $FINISHEDPIZZA;
	fi
	
	if [ ! $INITIALISED ]; then
		exit 0
	fi

# Get a random pizza from pizzas and place it:
		
		INGREDIENTLIST=$( find $INGREDIENTS -maxdepth 1 -type f \( -name "*.png" -o -name "*.PNG" -o -name "*.jpg" -o -name "*.JPG" \) )
		
		for INGREDIENT in $INGREDIENTLIST; do
		
			RANDOMPIZZA=$( find $PIZZAS -maxdepth 1 -type f \( -name "*.png" -o -name "*.PNG" -o -name "*.jpg" -o -name "*.JPG" \) | shuf -n 1 ) 
			
			echo "Pizza: "$(basename $RANDOMPIZZA)" + "$(basename $INGREDIENT)

		
				FINISHEDPIZZAIMAGE=$FINISHEDPIZZA"/"$(basename $INGREDIENT)
					echo "Applying ingredient: -> "$FINISHEDPIZZAIMAGE
					convert $INGREDIENT'[160000@]' $INGREDIENT"_converted"
					convert $RANDOMPIZZA'[640000@]' $RANDOMPIZZA"_converted"
					composite -dissolve 100% -gravity center $INGREDIENT"_converted" $RANDOMPIZZA"_converted" $FINISHEDPIZZAIMAGE
		done
		echo "Done!"
	
exit 0
