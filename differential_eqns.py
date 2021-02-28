# differential equations to solve
def differentials(y, t, N, beta, gamma, mu):
    S, I, R, D = y
    dS_dt = -beta * S * I / N
    dI_dt = beta * S * I / N - gamma * I - mu * I
    dR_dt = gamma * I
    dD_dt = mu * I
    return dS_dt, dI_dt, dR_dt, dD_dt