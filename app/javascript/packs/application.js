// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "controllers"
import "bootstrap"

const Swing = require("swing");


// Prepare the cards in the stack for iteration.
const cards = [].slice.call(document.querySelectorAll('.row .card'));

// An instance of the Stack is used to attach event listeners.
const stack = Swing.Stack();

cards.forEach((targetElement) => {
  // Add card element to the Stack.
  stack.createCard(targetElement);
});

// Add event listener for when a card is thrown out of the stack.
stack.on('throwout', (event) => {
  // e.target Reference to the element that has been thrown out of the stack.
  // e.throwDirection Direction in which the element has been thrown (Direction.LEFT, Direction.RIGHT).
  if (event.throwDirection == Swing.Direction.UP) {
    console.log("updating goals completion")
  } else if (event.throwDirection == Swing.Direction.LEFT) {
    console.log("lazy bum")
  } else if (event.throwDirection == Swing.Direction.RIGHT) {
    console.log("updating goals to done")
  } 
});

// Add event listener for when a card is thrown in the stack, including the spring back into place effect.
stack.on('throwin', () => {
  console.log('Card has snapped back to the stack.');
});