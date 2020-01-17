var deepEqual = require('deep-equal')

function transition (operand, operator) {
  transform = Object.create(operand)
  transform.change(operator)
  return {
    operator: operator,
    operand: operand,
    transform: transform
  }
}

function transformation (operands, operator) {
  if (typeof operands === 'array') {
    transitions = Array(operands.length)
  }
  else if (typeof operands === 'object') {
    transitions = {}
  }
  else {
    throw "operands must be an array or an object"
  }
  Object.keys(operands).forEach(function (key) {
      transitions[key] = transition(operands[key], operator)
  })

  return transitions
}

function skin (pigment) {
  return {
    pigment: pigment,
    change: function (operator) {
      if (operator == "sunlight") {
        console.log("Tanning")
        this.pigment++
      }
    }
  }
}

function soil (heat) {
  return {
    heat: heat,
    change: function (operator) {
      if (operator == "sunlight") {
        this.heat++
      }
    }
  }
}

  function pigment () {
  return {
    saturation: 100,
    change: function (operator) {
      if (operator == "sunlight") {
        this.saturation--;
      }
    }
  }
}

function deepContains (world, waldo) {
  Object.keys(world).forEach(function (key) {
    if (deepEqual(world[key], waldo)) {
      return true
    }
  })
  return false
}

function isClosed (transformation) {
  //Extract Operands
  //Extract Transforms
  //Iterate over transforms
  //boolean-and all the deepContains(operands, transform)
}

function sunlightTransformation () {
  world = {
    mySkin: skin(20),
    theSoil: soil(10),
    myShirtColor: pigment()
  }
  tf = transformation(world, "sunlight")
  console.log(tf)
  console.log(isClosed(tf))
}

sunlightTransformation()
