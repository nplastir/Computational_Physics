#let marg = 1 / 12
#let W = 480pt
#let H = 3 / 4 * W

#set page(
    width: W,
    height: H,
    margin: marg * 100%
)

#let pm = math.plus.minus
#let mp = math.minus.plus

$
    (1 + 1/2 i tau H)psi_j^(n+1) = (1 - 1/2 i tau H)psi_j^(n)
$
$
    H psi_j = -1/h^2(psi_(j+1) - 2 psi_j + psi_(j-1)) + V_j psi_j
$
$
    lambda = (2 h^2) / tau
$
#v(0.5cm)
$
    (1 pm 1/2 i tau H)psi_j 
    &= psi_j mp i tau / (2 h^2)(psi_(j+1) - 2 psi_j + psi_(j-1)) pm i tau / (2 h^2) h^2 V_j psi_j\
    &= psi_j mp 1/lambda psi_(j+1) pm 2 i/lambda psi_j mp i/lambda psi_(j-1) pm h^2 i/lambda V_j psi_j\
    &= -i/lambda (pm psi_(j-1) + (i lambda mp h^2 V_j mp 2) psi_j pm psi_(j+1))
$
Επαναληπτική σχέση: Θα έχει το $-i\/lambda$ και στα δύο μέλη
$
    &psi_(j-1)^(n+1) + (i lambda - h^2 V_j - 2) psi_j^(n+1) + psi_(j+1)^(n+1) =\
    = -&psi_(j-1)^n + (i lambda + h^2 V_j + 2) psi_j^n - psi_(j+1)^n
$
