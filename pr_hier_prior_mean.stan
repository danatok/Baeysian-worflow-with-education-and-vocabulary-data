// Comparison of k groups with common variance and
// hierarchical prior for the mean
data {
    int<lower=0> N; // number of data points
    int<lower=0> K; // number of groups
    int<lower=1,upper=K> x[N]; // group indicator
    vector[N] y; //
}
parameters {
    real mu0;             // prior mean
    real<lower=0> sigma0; // prior std
    vector[K] mu;         // group means
    real<lower=0> sigma;  // common std
}
model {
  //mu ~ normal(mu0, sigma0); // population prior with unknown parameters
  //y ~ normal(mu[x], sigma);
  mu0 ~ normal(0,5);      // weakly informative prior
  sigma0 ~ normal(0,4);     // weakly informative prior
  mu ~ normal(mu0, sigma0); // population prior with unknown parameters
  sigma ~ normal(0,4);      // weakly informative prior
  y ~ normal(mu[x], sigma);
}
generated quantities {
  vector[N] log_lik;
  for (i in 1:N)
  log_lik[i] = normal_lpdf(y[i] | mu[x[i]], sigma);
}