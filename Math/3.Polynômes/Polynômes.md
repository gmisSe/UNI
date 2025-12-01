# Fonctions polynômes du 4nd degré. 

Fonction du genre $ax^{2}+bx+c$, où a,b,c sont des nombres, avec $a\neq_{0}$ .

## 1

La représentation graphique s'appelle la *parabole* 
- Si $a>0$ parabole tournés vers le haut
- Si $a<0$ parabole tournés vers le bas

# La dérivation 

*Soit $f$ une fonction dérivable sur un intervalle $I$. 
On note $f'$ ou $\frac{df}{dx}$ ou $f$ la fonction dérivée de f par rapport à la variable $x$*

## 1 Dérivée usuelles 




| Fonction $f$                  | Dérivée $f'$            | Domaine de dérivabilité                                        |
| ----------------------------- | ----------------------- | -------------------------------------------------------------- |
| $C=\text{fonction constante}$ | $0$                     | $C \in \mathbb{R}$                                             |
| $x$                           | $1$                     | $x \in \mathbb{R}$                                             |
| $x^{n}$                       | $nx^{n-1}$              | $x \in \mathbb{R}$ si $n>0$<br>$x \in \mathbb{R^{*}}$ si $n<0$ |
| $\frac{1}{x}$                 | $-\frac{1}{x^{2}}$      | $x \in \mathbb{R^{*}}$                                         |
| $\sqrt{ x }$                  | $\frac{1}{2\sqrt{ x }}$ | $x \in \space ]0;+ \infty[$                                    |
| $\sin x$                      | $\cos x$                | $x \in \mathbb{R}$                                             |
| $\cos x$                      | $-\sin x$               | $x \in \mathbb{R}$                                             |


## 2 Opérations sur les dérivées 

$k$ désigne un nombre. $u$ et $v$ sont deux fonctions dérivables sur un même intervalle.
- $(u+v)'(x)=u'(x)+v'(x)$
- $(u+v)'=u'+v'$
- $(u-v)'=u'-v'$

- $(k.u(x))'=k.u'(x)$
- $(k.u)'=k.u'$

- $(u(x).v(x))'= u'(x).v(x)+v'(x).u(x)$
	- $(u.v)'=u'v+v'u$

- $\left( \frac{u(x)}{v(x)} \right)'= \frac{u'(x)v(x)-v'(x)u(x)}{[v(x)]^{2}}$
	- $\left( \frac{u}{v} \right)'= \frac{u'v-v'u}{v^{2}}$

## 3 Variations d'une fonction et extrémum 

f est une fonction dérivable sur un intervalle $I$ ; $f'$ est sa fonction dérivées. 

### Sens de variation def. 

- Si ${} f'(x)>0 {}$ sur $I$, alors $f(x)$ est croissant sur $I$
- Si $f'(x)< 0$ sur $I$, alors $f(x)$ est décroissante sur $I$
- Si $f'(x)=0$ sur $I$, alors $f(x)$ est constante sur $I$ 
### soit "a" un nombre appartenant $I$, 

Si $f(x)$ s'annule en $x=a$,  en changeant de signe, alors la fonction $f$ admet un extrémum en $x=a$ 

La courbe representative de $f$ admet une tangente horizontale en ce point.

## 4 Equation de la tangente 

$f$ est une fonction dérivable sur un intervalle $I$ ; $f'$ est sa dérivée et "a" est un nombre dans $I$ .
*L'équation de la tangente à la courbe représentative de $f$ en $x=a$ est  : $y= f'(a)(x-a)+f(a)*

