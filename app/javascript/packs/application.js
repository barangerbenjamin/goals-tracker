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
const cards = [].slice.call(document.querySelectorAll('.cards .swipe'));

// An instance of the Stack is used to attach event listeners.
const stack = Swing.Stack();

cards.forEach((targetElement) => {
  // Add card element to the Stack.
  stack.createCard(targetElement);
});

function lowerDataPosition() {
  console.log('1')
  const cards = [].slice.call(document.querySelectorAll('.cards .goal-card'));
  const positions = cards.map(card => {
    return parseInt(card.dataset.position)
  })
  // console.log(!positions.includes(1))
  // console.log('inside')
  cards.forEach(card => {
    setTimeout(function() {
      card.dataset.position = card.dataset.position - 1
    }, 120);
  })
}

function slotInBeforeDeckEnd(event, isDeckEnd) {
  if (isDeckEnd) {
    const cards = [].slice.call(document.querySelectorAll('.cards .goal-card'));
    const positions = cards.map(card => {
      return parseInt(card.dataset.position)
    })
    const highestId = positions.sort().at(-1)
    event.target.dataset.position = highestId + 1
    stack.getCard(event.target).throwIn(0, 0)
    // stack.getCard(event.target).destroy()
  } else {
    const deckEnd = document.querySelector('.goal-card.deck-end')
    event.target.dataset.position = deckEnd.dataset.position
    deckEnd.dataset.position = parseInt(deckEnd.dataset.position) + 1
    stack.getCard(event.target).throwIn(0, 0)
  }
}
function slotInAfterDeckEnd(event, isDeckEnd) {
  const deckEnd = document.querySelector('.goal-card.deck-end')
  if(!isDeckEnd) {
    event.target.classList.remove('not-actioned')
    event.target.classList.add('actioned')
  }
  const cards = [].slice.call(document.querySelectorAll('.cards .goal-card'));
  const positions = cards.map(card => {
    return parseInt(card.dataset.position)
  })
  const highestId = positions.sort().at(-1)
  event.target.dataset.position = highestId + 1
  stack.getCard(event.target).throwIn(0, 0)
}

function slotInAndRemove(event, timeoutDuration) {
  stack.getCard(event.target).throwIn(0, 0)
  setTimeout(function() {
    event.target.remove()
  }, timeoutDuration);
}

function updateGoal(event, data) {
  fetch(`/goals/${event.target.dataset.goalId}`, {
    method: "PATCH",
    headers: {"Content-Type": "application/json", 'X-CSRF-Token': Rails.csrfToken()},
    body: JSON.stringify(data)
  })
}

stack.on('throwout', (event) => {
  // console.log("yes, i think so")
  if (event.throwDirection == Swing.Direction.UP) {
    if(event.target.hasAttribute('data-goal-id')) {
      slotInBeforeDeckEnd(event, false)
      updateGoal(event, {goal: {complete: false}, no_action: true})
    } else {
      slotInBeforeDeckEnd(event, true)
    }
    lowerDataPosition()
  } else if (event.throwDirection == Swing.Direction.LEFT) {
    if(event.target.hasAttribute('data-goal-id')) {
      updateGoal(event, {goal: {complete: false}})
      slotInAfterDeckEnd(event, false)
    } else {
      slotInAfterDeckEnd(event, true)
    }
    lowerDataPosition()
  } else if (event.throwDirection == Swing.Direction.RIGHT) {
    updateGoal(event, {goal: {complete: true}})
    slotInAndRemove(event, 500)
    // console.log('here')
    lowerDataPosition()
   }
});

const incomplete = document.querySelector('.incomplete')

incomplete.addEventListener('click', () => {
  // console.log('hjeya')
  incomplete.classList.toggle('expanded')
  const deckEnd = document.querySelector('.goal-card.deck-end')
  if(stack.getCard(deckEnd)) {
    // stack.getCard(deckEnd).destroy()
  }
  const cards = [].slice.call(document.querySelectorAll('.cards .goal-card.actioned'));
  cards.forEach(card => {
    card.classList.remove('actioned')
    card.classList.add('not-actioned')
  })
  // const deckEnd = document.querySelector('.goal-card.deck-end')
  if(incomplete.classList.contains('expanded')) {
    incomplete.innerHTML = '<i class="fas fa-folder-open"></i>'
    deckEnd.classList.add('shadow')
  } else {
    incomplete.innerHTML = '<i class="fas fa-folder"></i>'
    deckEnd.classList.remove('shadow')
    cards.forEach(card => {
      // card.classList.remove('actioned')
      // card.classList.add('actioned')
    })
  }
  stack.createCard(deckEnd).throwOut(0, -700)
})

stack.on('throwin', () => {
  // console.log('Card has snapped back to the stack.');
});
