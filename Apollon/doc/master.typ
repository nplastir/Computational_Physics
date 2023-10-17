#let marg = 1 / 12
#let W = 480pt
#let H = 3 / 4 * W
#let content_width = W - 2 * W * marg
#let primary_color = olive.lighten(20%)
#let code_color = gray.lighten(70%)
#let img_dir = "../stochastic/master/discrete/img/"

#let top_bar = {
    place(
        top + left,
        block(
            width: W,
            height: H * 13.5%,
            fill: primary_color
        )
    )
    place(
        top + right,
        block(
            width: W / 2,
            height: H * 13.5%,
            fill: olive.darken(25%)
        )
    )
}

#let code_ref(code) = [
    #h(0.5%)
    #box(fill: code_color, outset: 3pt, code)
    #h(0.5%)
]

#let code_block_num = counter("code block")

#let code_block(code, lab: str) = [
    #set align(center)
    #block(
        fill: code_color,
        inset: 4pt,
        align(left, code)
    )
    code block #code_block_num.display() #label("cb:" + lab)
    #code_block_num.step()
]

#let NEWPAGE(title) = [
    #pagebreak()
    = #title
    #v(2%)
]

// #show math.equation: set text(font: "New Computer Modern Math")

#set page(
    width: W,
    height: H,
    numbering: "1",
    margin: marg * 100%
)

// #set text(
//     font: "New Computer Modern"
// )

#set align(center)
#v(10%)
#block(
    fill: primary_color,
    inset: 12pt,
    radius: 4pt,
    text(
        size: 22pt,
        weight: "bold",
        "Ασκήσεις Υπολογιστικής Φυσικής"
    )
)

Εξίσωση Master
#v(18%)
Γρηγοράς Απόλλων

7110112200203

#text("apollon@phys.uoa.gr")


#set align(left)
#set page(
    background: top_bar
)

#NEWPAGE("Εισαγωγή")
Γενική συνάρτηση επιλογής μετάβασης: Επιλέγει τυχαία ένα από τα #code_ref[``possible_results``] με βάση τους ρυθμούς #code_ref[``transition_rates``]. Επιστρέφει και το χρονικό διάστημα το οποίο χρειάστηκε για την μετάβαση.

#code_block(lab: "pick_transition")[
```Python
# file: utils.py
import random
import numpy as np

def pick_transition(
    possible_results: np.array, transition_rates: np.array
):
    transition_intervals = transition_rates.cumsum()
    rate_sum = transition_intervals[-1] # last entry

    R = random.random() * rate_sum
    result_idx = (transition_intervals > R).nonzero()[0][0]

    dt = -np.log(random.random()) / rate_sum

    return (dt, possible_results[result_idx])
```
]
// #align(center, "hi")

#NEWPAGE("Αμφίδρομη αντίδραση")
Έστω $A,X$ δυνατές καταστασεις που μεταβαίνουν μεταξύ τους.
$ A harpoons.rtlb X $


#grid(
    columns: (content_width * 60%, content_width * 40%),
    [
        Ρυθμοί μετάβασης αν $A$ ο (σταθερός) αριθμός των $A$ και $N$ ο αριθμός των $X$:
        
        $ 
            W_(N+1,N) &= k_1 A\
            W_(N-1,N) &= k_2 N 
        $

        Ρυθμοί μετάβασης αν $A$ ο (σταθερός) συνολικός αριθμός των $A$ και $X$ και $N$ ο αριθμός των $X$:
        
        $   
            W_(N+1,N) &= k_1 (A - N)\
            W_(N-1,N) &= k_2 N 
        $
    ],
    code_block(lab: "two_way_0")[
```Python
# file: two_way.py
import numpy as np
import utils

A = 20; N = 20
k1 = 1; k2 = 1

Tsim = 10000

t = 0
```
    ]
)


#NEWPAGE("Αμφίδρομη αντίδραση")


#grid(
    columns: (content_width / 2, content_width / 2),
    code_block(lab: "two_way_1")[
```Python
# the number of A is constant
bins = 50
P = np.zeros(bins)

transitions = np.array([1, -1])
rates = np.array([k1 * A, k2 * N])
while t < Tsim:
    dt, dN = utils.pick_transition(
        transitions,
        rates
    )

    t += dt; N += dN
    rates[1] += k2 * dN

    try: P[N] += dt
    except IndexError: pass

P /= t
```
    ],
    code_block(lab: "two_way_2")[
```Python
# the number of A is not constant
bins = 20
P = np.zeros(bins)

transitions = np.array([1, -1])
rates = np.array([k1*(A-N), k2 * N])
while t < Tsim:
    dt, dN = utils.pick_transition(
        transitions,
        rates
    )

    t += dt; N += dN
    rates[0] -= k1 * dN
    rates[1] += k2 * dN

    try: P[N] += dt
    except IndexError: pass
P /= t
```
    ]
)


#NEWPAGE("Αμφίδρομη αντίδραση")

#grid(
    columns: (content_width / 2, content_width / 2),
    image(img_dir + "twr-0.png"),
    image(img_dir + "twr-1.png")
)