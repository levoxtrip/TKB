# Creative Coding Algorithms

# Position Elements on Angles From Center

```JS
let radius = 10;
let numBranches = 3;
for(let i = 0; i<elements.count;i++){
    let modIndex = i%numBranches;
    let angle = (modIndex/numBranches) * Math.PI*2;
    let ranRadius = Math.random()*radius

    position[i].x = Math.cos(angle)*ranRadius;
    position[i].x = 0;
    position[i].z = Math.sin(angle)*ranRadius;
}
```

# Position Elements on Angles From Center With Spin

```JS
let radius = 10;
let numBranches = 3;
let spin = 0.1;
for(let i=0; i<elements.count;i++){
    let ranRadius = Math.random()*radius;
    let spinAngle = ranRadius + spin;
    let pIndex = i%numBranches;
    let branchAngle = (pIndex/numBranches)*Math.PI*2;
    position[i].x = Math.cos(branchAngle+spinAngle)*ranRadius;
    position[i].y = 0
    position[i].z = Math.sin(branchAngle+spinAngle)*ranRadius;
}

```

# Manipulate Random Values Distribution

## Push smaller values closer to 0 and bigger values closer to 1

We can use `.pow` to not have a linear distribution but to move the random values closer to 0 when the random value is small and closer to one when the random value is bigger

`Math.pow(Math.random(),randomnessPower)`
This just creates positive values. When we want to have also some values distributed to a negative axis we can multiply it with a random 1/-1
`Math.pow(Math.random(),randomPower) * (Math.random() <0.5 ? 1:-1)`
