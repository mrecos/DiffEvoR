# `DiffEvoR`
## Differential Evolution Algorithm in R
An implementation of the Differential Evolution (DE) algorithm; a black-box parameter optimization and fitting algorithm. This algorithm uses _mutation_ and _recombination_ evolutionary strategies to explore the parameter space of the objective function to minimize its `fitness` (e.g. value or loss).

<img align="center" src="https://raw.githubusercontent.com/mrecos/DiffEvoR/master/images/DE_3D.gif" alt="DE Algorithm">

The code and algorithm that are the basis for this repo come from a Python implementation in this very cool and intuitive [blog post](https://pablormier.github.io/2017/09/05/a-tutorial-on-differential-evolution-with-python/) by [Pablo R. Mier](https://twitter.com/PabloRMier). The wire frame plots alone are worth the price of admission.  The origin of the DE algorithm is cited Pablo's past as [R. Storn and K. Price 1997](https://link.springer.com/article/10.1023%2FA%3A1008202821328?LI=true). I came across this post at the recommendation of [Dan Kondratyuk](https://twitter.com/hyperparticle) from his fabulous work on [one pixel advisarial attacks on CNN in Keras](https://github.com/Hyperparticle/one-pixel-attack-keras). I read Pablo's blog and thought it would be fun to port this to R; so that is what we have here. I added to the code a little bit to make it work with both function minimization as well as loss functions (e.g. RMSE).

