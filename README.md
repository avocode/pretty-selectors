Pretty Selectors
================

> Pretty selectors takes your ugly text and transforms it to nice CSS selectors

## Installation

`npm install pretty-selectors`

## Input/Output example

![](http://f.cl.ly/items/2H3O3y0z2t46042s0J1i/Screen%20Shot%202014-10-06%20at%2015.55.37.png)

## Code example

    var PrettySelectors = require('pretty-selectors');

    var selector = PrettySelectors('Moje mama', {separator: 'snake',
                                    selector: 'id',
                                    maxWords: 3});
    // result: #moje_mama

## Api

    PrettySelectors(text, object)

### text (string, required)

### object.separator (string, optional, default: 'dash')

Options: dash, snake, camel

### object.selector (string, optional, default: 'class')

Options: class, id, element

### object.maxWords (number, optional, default: 0 means no text stripping)
