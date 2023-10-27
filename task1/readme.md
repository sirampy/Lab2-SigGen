# creating sinerom.mem
singen.py creates sinerom.mem, which is a cos wave in hex ranging from 0 to 0xff:
```python
import math
import string
f = open("sinerom.mem","w")
for i in range(256):
    v = int(math.cos(2*3.1416*i/256)*127+127)
    if (i+1)%16 == 0:
        s = "{hex:2X}\n"
    else:
        s = "{hex:2X} "
    f.write(s.format(hex=v))

f.close()
```

# what I did:
* I created / modified a rom and counter to create a sinegen
* I created a testbench with an elegant exiting solution for my program as well as passing the rotary encoder's value into the step size for the counter to make the frequancy variable (AKA the **_challenge_**)

