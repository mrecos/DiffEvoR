
de <- function(fobj, bounds,x = NULL,y = NULL,mut=0.8, crossp=0.7, popsize=20, its=1000, verbose=1){
  dimensions = length(bounds)
  pop   = replicate(n, runif(popsize)) 
  min_b = sapply(bounds, min)
  max_b = sapply(bounds, max)
  diff  = abs(min_b - max_b)
  pop_denorm = min_b + pop * diff # scaled matrix cols to bounds
  if(is.null(x) & is.null(y)){
    fitness = apply(pop_denorm, 1, fobj) # output of fobj on parameters
  } else if(!is.null(x) & !is.null(y)){
    fitness = apply(pop_denorm, 1, fobj, x=x, y=y) # output of fobj on parameters & x, y
  }
  best_idx = which.min(fitness) # index of best parametr set
  best = pop_denorm[best_idx,] # best set of scaled parameters
  if(verbose==1) pb <- txtProgressBar(min = 0, max = its, style = 3)
  for(i in seq_len(its)){
    for(j in seq_len(popsize)){
      idxs = seq_len(popsize)[-j]
      abc = pop[sample(idxs,3),]
      a = abc[1,]; b = abc[2,]; c = abc[3,]
      mutant = a + mut * (b - c) # mutate a,b,c vectors
      mutant[mutant>1] = 1; mutant[mutant<0] = 0 # clip 0 to 1
      cross_points = runif(dimensions) > crossp
      if(!all(cross_points)){ # set rand 1 to TRUE if all FALSE
        cross_points[sample(1:dimensions,1)] = TRUE
      }
      trial = pop[j,]; trial[cross_points] = mutant[cross_points] # cross over
      trial_denorm = min_b + trial * diff # scale to bounds
      # f = fobj(trial_denorm)
      if(is.null(x) & is.null(y)){
        f = fobj(trial_denorm) # output of fobj on parameters
      } else if(!is.null(x) & !is.null(y)){
        f = fobj(trial_denorm, x=x, y=y) # output of fobj on parameters & x , y
      }
      if(f < fitness[j]){
        fitness[j] = f
        pop[j,] = trial
        if(f < fitness[best_idx]){
          best_idx = j
          best = trial_denorm
        }
      }
    } # j loop
    if(verbose == 1) setTxtProgressBar(pb, i)
    if(verbose == 2) cat(i,":",fitness[best_idx],":",best,"\n")
  } # i loop
  if(verbose == 1) close(pb)
  return(list(best,fitness[best_idx]))   
}

## Example 1; 4 dimensions
n = 4
bounds = rep(list(c(-5,5)), n)
popsize = 10
fobj = function(w) sum(w^2)/length(w)
its = 100
mut = 0.8
crossp = 0.7
de(fobj, bounds, its = its)

# Example 2; 32 dimensions
n = 32
bounds = rep(list(c(-100,100)), n)
result = de(fobj, bounds, its = 3000, verbose = 0)

# Example 3
len_out = 500
x = seq(0,10, length.out = len_out)
y = cos(x) + runif(len_out,-0.2,0.2)
plot(x, y)
curve(cos(x), col = "blue", add=TRUE, lwd = 2)

n = 6 # number of parameters (bias + n-1 degree exponent)
bounds = rep(list(c(-5,5)), n)
fmodel = function(w,x){
  model = w[1]+w[2]*x+w[3]*x^2+w[4]*x^3+w[5]*x^4+w[6]*x^5
  return(model)
}
rmse = function(w,x,y){
  y_pred = fmodel(w,x)
  err = sqrt(sum((y - y_pred)^2) / length(y))
  return(err)
}

results <- de(rmse, bounds, x=x, y=y, its=10000, verbose=1)
print(results)

plot(x, y)
curve(cos(x), col = "blue", add = T, lwd = 2)
curve(fmodel(results[[1]],x), add = T, col = "red", lwd =2, lty=2)



