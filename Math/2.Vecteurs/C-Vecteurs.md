

## 4- Soustraction de 2 vecteurs (voir polycopié)

## 5- Produit d'un vecteur pas un scalaire (voir polycopié)

 Le produit d'un vecteur $\vec{v}$ par un nombre $k$ , donne un autre vecteur que l'on note $k \vec{v}$, il a la même direction que le vecteur $\vec{v}$.

- Si $k > 0$, $k \vec{v}$ et $\vec{v}$ ont le même sens et $||k \vec{v}||=k ||\vec{v}||$
- Si $k < 0$, $k \vec{v}$ est de sens opposé à $\vec{v}$ et $||k \vec{v}||=-k ||\vec{v}||$

$\vec{CD}=2 \vec{AB}$
$\vec{EF}=\frac{1}{2} \vec{AB}$
$\vec{GH}=\frac{3}{4} \vec{AB}$
Tracer $\vec{IJ}=-3\vec{EF}.$
![[EFIJ]]


# 3- Coordonnées d'un vecteur  

Dans l'espace muni d'un repère ($O, \vec{i}, \vec{j}, \vec{k}$), tout vecteur est définie de façon unique par la donnée de 3 nombres notés : 
- abscise 
- ordonnée
- côté 
Ce sont ses coordonnées.

Exemple : Soit $M(x_{M};y_{M};Z_{M})$ un point de l'espace. 
Alors $\vec{OM} \begin{pmatrix} x_{M} \\ y_{M} \\ z_{M}\end{pmatrix}$ et on écrit dans le repère $(O; \vec{i}, \vec{j}, \vec{k})$:
$\vec{OM}=x_{M} \vec{i}+y_{M} \vec{j} + z_{m} \vec{k}$

![[poly8]]


## 1- Calcule des coordonnes d'un vecteur

Dans un repère de l'espace, on considère deux points $A(x_{A};y_{A};z_{A})$ et $B(x_{B};y_{B};z_{B})$
les coordonnées de $\vec{AB}$ sont : 
$\vec{AB}\begin{pmatrix} x_{B} - x_{A} \\ y_{B}-y_{A} \\ z_{B}-z_{A}\end{pmatrix}$


Propriétés : Soit $\vec{u} \begin{pmatrix} x \\ y \\ z\end{pmatrix}$  et $\vec{v} \begin{pmatrix}x' \\ y' \\ z'\end{pmatrix}$ (x' y' z').

$\vec{u}=\vec{v} \leftrightarrow \langle \begin{array}{c}  x=x' \\ y=y' \\ z=z' \end{array}$

$\vec{u}=-\vec{v} \leftrightarrow \langle \begin{array}{c}  x=-x' \\ y=-y' \\ z=-z' \end{array}$



## Norme d'un vecteur

(Dans un repère orthonormé de l'espace)

*Projeté orthogonal d'un point*
Le projeté orthogonal d'un point $A$ sur une droite $(d)$, est le point $M$ de $(d)$ tel que : $(AM)\bot(d)$ 
![[D-projeté-orthogonal]]
Le projeté orthogonal d'un point A sur un plan $(P)$, est le point $M$ de $(P)$ tel que $(AM)\bot(d)$ 

![[D-projeté-orthogonal2]]

*Calcule de la norme*

Connaissant $A(x_{A};y_{A};z_{A})$ et $B(x_{B};y_{B};z_{B})$, $||\vec{AB}|| = \sqrt{ (x_{B}-x_{A})^{2}+(y_{B}-y_{A})^{2}+(z_{B}-z_{A})^{2} }$
Si $\vec{u}\begin{pmatrix}x \\ y \\ z\end{pmatrix}$, alors $||\vec{u}||=\sqrt{ x^{2}+y^{2}+z^{2} }$

# 4 Le produit scalaire

## 1 Définition

Le produit scalaire de deux vecteurs $\vec{AB}$ et $\vec{CD}$ est le nombre noté :
$$
\vec{AB} \cdot \vec{CD}
$$

### On le calcule par :

$$
\vec{AB} \cdot \vec{CD} = ||\vec{AB}|| \times ||\vec{CD}|| \times \cos(\widehat{\vec{AB}, \vec{CD}})
$$

### Propriété
$\vec{u}.\vec{v}=\vec{v}.\vec{u}$


## 3 Autres calculs du produit scalaire.

### a) Avec les coordonnées

Soit $\vec{u}\begin{pmatrix}x \\ y \\ z \end{pmatrix}$ et $\vec{v}\begin{pmatrix}x' \\ y' \\ z'\end{pmatrix}$ deux vecteurs de l'espace ramené è un repère orthonormé. 
> $\vec{u}.\vec{v}=xx'+yy'+zz'$

[[EX4]]


### b) Formules de polarisation 

Cas de configuration triangulaires. 

* Si $\vec{u}$ et $\vec{v}$ ont la même origine : 
  > $\vec{u}.\vec{v}= \frac{1}{2}(||\vec{u}||^{2}+||\vec{v}||^{2}-||\vec{u}-\vec{v}||^{2})$
  > $\vec{AB}.\vec{AC}=\frac{1}{2}(AB^{2}+AC^{2}-||\vec{AB}-\vec{AC}||^{2})$
  > or $\vec{AB}-\vec{AC}=\vec{AB}+\vec{CA}=\vec{CA}+\vec{AB}=\vec{CB}$
  > donc $\vec{AB}.\vec{AC}=\frac{1}{2}(AB^{2}+AC^{2}-CB^{2})$
- Dans les autres cas :
> $\vec{u}.\vec{v}=\frac{1}{2}(||\vec{u}+\vec{v}||^{2}-||\vec{u}||^{2}-||\vec{v}||^{2})$

[[EX5]]

## 4 Orthogonalité 

*2 vecteurs sont orthogonaux quand leur directions forment un angle droit*

### Propriété 

2 vecteurs $\vec{u}$ et $\vec{v}$ sont orthogonaux si leur produit scalaire est nul. 
$\vec{u}\bot \vec{v} \leftrightarrow \vec{u}.\vec{v}=0$

$\vec{u}\bot \vec{v}\rightarrow \widehat{(\vec{u};\vec{v})}=90°$
$\rightarrow \cos(\widehat{\vec{u};\vec{v}})=\cos 90=0$
donc $||\vec{u}.\vec{v}||=||\vec{u}||\times||\vec{v}||\times \cos 90$
$= ||\vec{u}||\times||\vec{v}||\times0$

## 5 Linéarité du produit scalaire 
- $\vec{u}.\vec{v}=\vec{v}.\vec{u}$
- $\vec{u}.(\vec{v}+\vec{w})=\vec{u}.\vec{v}+\vec{u}.\vec{w}$
- $\vec{u}.(\vec{v}-\vec{w})=\vec{u}.\vec{v}-\vec{u}.\vec{w}$
- $\vec{u}.(k \vec{v})=(k \vec{u}).\vec{v}=k \vec{u}.\vec{v}$
(k désigne un nombre réel) 

[[EX6]]

# 5- Le produit vectoriel 

Un repère orthonormé dans l'espace a ses 3 axes perpendiculaires , et la même norme pour les 3 vecteurs de base. 
=![[produit vecroriel]]
  
  
Soit $\vec{u}$ et $\vec{v}$, 2 vecteurs de l'espace même d'un repère orthonormé direct. 
Le produit vectoriel des vecteurs $\vec{u}$ et $\vec{v}$, est un autre vecteur noté $\vec{u}ch \vec{v}$
- sa norme :
	- $||\vec{u}ch \vec{v}||=||\vec{u}\times||\vec{v}||\times|\sin(\widehat{\vec{u},\vec{v}})|$
- sa direction : $\vec{u}ch \vec{v}$ est perpendiculaire au plan contenant $\vec{u}$ et $\vec{v}$.
- sons sens : Dans le plan qui contient $\vec{u}$ et $\vec{v}$, si on tourne dans le sens direct en allant de $\vec{u}$ vers $\vec{v}$, alors $\vec{u}ch \vec{v}$, viens vers nous. Sinon, il part dans le sens opposé 
## 2 Coordonnées d'un produit vectoriel

Soit 2 vecteurs $\vec{u}\begin{pmatrix}x\\ y\\ z \end{pmatrix}$ et $\vec{v}\begin{pmatrix}x'\\y'\\z'\end{pmatrix}$dans une base orthonormée directe.
$(\vec{i},\vec{j},\vec{k})$
$\vec{u}ch \vec{v}=(yz'-zy')\vec{i}+(zx'-xz')\vec{j}+(xy'-yx')\vec{k}$

donc $\vec{u}ch \vec{v}\begin{pmatrix}yz'-zy'\\zx'-xz'\\xy'-yx'\end{pmatrix}$
méthode pour trouver les coordonnées 
On alterne les signes : 


|                       | + sur $\vec{i}$                                                                                                       | - sur $\vec{k}$                                                                                                       | + sur $\vec{k}$                                                                                                       |
| --------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| $\vec{u}ch \vec{v}=+$ | $\begin{array}{c} \vec{i} \space x \space x' \\ \vec{j} \space y \space y' \\ \vec{k} \space z \space z' \end{array}$ | $\begin{array}{c} \vec{i} \space x \space x' \\ \vec{j} \space y \space y' \\ \vec{k} \space z \space z' \end{array}$ | $\begin{array}{c} \vec{i} \space x \space x' \\ \vec{j} \space y \space y' \\ \vec{k} \space z \space z' \end{array}$ |

$\vec{u} ch \vec{v} =+(yz'-zy')\vec{i}-(xz'-zx')\vec{j}+(xy'-yx')\vec{k}=(yz'-zy')\vec{i}+(zx'-xz')\vec{j}+(xy'-yx')\vec{k}$

## 3 

La norme de $\vec{u}ch \vec{v}$, est égale à l'aire du parallélogramme ayant $\vec{u}$ et $\vec{v}$ pour côtés consécutifs. 


### 4 Propriété

- $\vec{u}ch \vec{v}=- \vec{v}ch \vec{u}$
- 2 vecteurs $\vec{u}$ et $\vec{v}$ sont colinéaires (de même direction) si $\vec{u}ch \vec{v}= \vec{0}$
- $\vec{u}ch k.\vec{v}=k.\vec{u}ch v= k.(\vec{u}ch \vec{v})$ 
- $\vec{u}ch (\vec{v}+\vec{w}=\vec{u}ch \vec{v}+\vec{u}ch \vec{w}$ 

 
