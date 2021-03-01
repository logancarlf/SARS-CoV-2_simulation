# differential equations to solve
def differentials(y, t, N, beta, gamma, mu, v):
    S, I, R, D, V = y
    dS_dt = -beta * S * I / N - v * S
    dI_dt = beta * S * I / N - gamma * I - mu * I
    dR_dt = gamma * I
    dD_dt = mu * I
    dV_dt = v * S
    return dS_dt, dI_dt, dR_dt, dD_dt, dV_dt
