---
comments: true
tags:
  - VVVV
  - VVVV/StateMachine
---

# Automata UI
A *statemachine* is an abstract machine which can be in exaclty one of finite number of states

*State*  represents state of software - game-mode, highscore state of game
*Transition* - what happens between states
*Action* - triggering a transition to move form one state to another

![State machine](./img/StateMachineExample.png)

State machine allows us to control the behavior of our software

Provides overview of software flow.

## Automata UI Terminology
*Transition Time* time between states to drive animations

*State Time*  lock up a state for a certain time

*Init State* where the statemachine always stars from

*Ping Pong* transitions transitioning back and forth with one transition

*Actions*  Bang input Pins named by Transition hence Transition = Action


# Install
Install under dependency
`nuget install VL.AutomataUI`

# Editor
Create state `double left click`
Create transition `right click`
Delete transition and state `middle mouse click`
Set State in your VVVV patch `ctrl + click state`

# Same behavior for transitions
Give the transitions the same name so the same behavior gets executed.