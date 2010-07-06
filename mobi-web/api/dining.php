<?php

 require_once LIBDIR . "/harvard_dining.php";

 $urlBase = 'http://food.cs50.net/api/1.1/items?date=';

 switch ($_REQUEST['command']) {
 
	case 'breakfast':
	     $mealTime = '&meal=Breakfast&output=json';

	case 'lunch':
	     $mealTime = '&meal=Lunch&output=json';

	case 'dinner':
	     $mealTime = '&meal=Dinner&output=json';
 }

 echo(HARVARD_DINING::getMealData($urlBase, $_REQUEST['date'], $mealTime)); 


?>